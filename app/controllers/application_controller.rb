require 'csv'
require 'ostruct'
require 'will_paginate/array'
class ApplicationController < ActionController::Base
  include CharacteristicsHelper
  include FriendshipsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :banned?
  before_action :confirm_current_user
  before_action :set_search

  skip_before_action :confirm_current_user, :only => [:create, :update]
  after_action :user_activity

  def banned?
    if current_user.present? && current_user.banned
      sign_out current_user
      flash[:error] = "You have been blocked by at least three users. This is to protect students from harmful or inappropriate comments. If you feel this is a mistake, please e-mail safespacebear@gmail.com with the subject headline 'Mistakenly blocked.'"
      root_path
    end
  end

  def confirm_current_user
    not_accessible = ["conversations", "profiles", "characteristics", "messages", "friendships", "contents"]
    if (!current_user && not_accessible.include?(controller_name))
      flash[:error] = "Please log in or sign up to access that page."
      redirect_to root_path
    end

    if current_user && !(current_user.email == "user1@berkeley.edu")
      if controller_name == "contents"
        flash[:error] = "You do not have access to that page."
        redirect_to conversations_path
      end
    end
  end

  def redirect_user
    redirect_to '/404'
  end

  def liability_required
    redirect_to('/') if current_user && current_user.signed_liability.blank?
  end

  def toggle_appear_offline
    current_user.toggle_appear_offline if current_user

    respond_to do |format|
      format.js { render :template => 'layouts/toggle_appear_offline' }
      format.html { redirect_to :back }
    end
  end

  private

  def user_activity
  	 @current_user.try(:touch) if @current_user
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.banned?
      sign_out resource
      flash[:error] = "You have been blocked by at least three users. This is to protect students from harmful or inappropriate comments. If you feel this is a mistake, please e-mail safespacebear@gmail.com with the subject headline 'Mistakenly blocked.'"
      root_path
    elsif resource.showcase
      intro_info_path
    elsif resource.peer_counselor
      recommendations_path
    else
      conversations_path || session["user_return_to"]
    end
    # session["user_return_to"] request.env['omniauth.origin'] || stored_location_for(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:username, :email, :password, :password_confirmation, :passcode)
    end
    # devise_parameter_sanitizer.for(:account_update) << :username
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:username, :email, :password, :password_confirmation, :passcode)
    end
  end

  def build_query
    @search = Profile.search(params[:q])
    puts "hi"
    puts params
    @search.build_sort if @search.sorts.empty?
    # @profiles = @search.result(distinct: true).reject{ |p| p.user == current_user}.select { |p| !current_user.block_exists?(p.user) }
    @profiles = order_preferences(@search.result(distinct: true).reject{ |p| p.user == current_user}).select { |p| !current_user.block_exists?(p.user) }
    @profiles = put_peer_counselor_first(@profiles) if !current_user.peer_counselor

    @num_profiles = @profiles.count
    @profiles.paginate(page: params[:page], per_page: @num_profiles)
  end

  def get_all_profiles
    @profiles = Profile.all
    #
  end

  def order_preferences(search_query)
    if params[:preferences]
      @sorted_preferences = (params[:preferences].permit(params[:preferences].keys)).to_h.sort_by{|k, v| v}.reverse.to_h
      char_ids = params[:q][:characteristics_id_in_any]
      search_chars = build_search_chars(char_ids)
      @sorted_preferences.each do |category, rank|
        if rank != '0'
          search_query = put_preference_first(search_query, category, search_chars)
        end
      end
    end

    return search_query
  end

  def put_preference_first(search_query, category, search_chars)
    matching_characteristics = search_chars

    if matching_characteristics
      matching_profiles = search_query.select { |profile| !(profile.characteristics & matching_characteristics["#{category}"]).empty? }
      search_query = search_query.reject{ |profile| matching_profiles.include? profile }
      search_query = matching_profiles + search_query
    end

    # if matching_characteristic
    #   matching_profiles = search_query.select { |profile| profile.characteristics.include? characteristic }
    #   search_query = search_query.reject!{ |profile| profile.characteristics.include? characteristic }
    #   search_query = matching_profiles ? matching_profiles + search_query : search_query
    # end

    return search_query
  end

  def build_search_chars(char_ids)
    @search_chars = {}
    char_ids.each do |id|
      if !id.empty?
        @char = Characteristic.find id
        if @search_chars["#{@char.category}"]
          @search_chars["#{@char.category}"] << @char
        else
          @search_chars["#{@char.category}"] = [@char]
        end
      end
    end
    return @search_chars
  end

  def put_peer_counselor_first(search_query)
    peer_counselors = User.peer_counselors
    search_query = search_query.reject{ |p| peer_counselors.include? p.user }

    for i in 0..search_query.count
      search_query.insert(i, peer_counselors.sample.profile) if i % 15 == 0
    end

    return search_query
  end

  def query_online_only?
    return params[:q][:online_or_all_profiles] == "1" if params[:q]
  end

  def query_sort_type
    # return params[:q][:s]["0"][:name] if params[:q]
    return params[:q]
  end

  def query_all_counselors?
    return params[:q][:user_peer_counselor_true] == "1" if params[:q]
  end

  def set_search
    @search = Profile.search(params[:q])
  end
end
