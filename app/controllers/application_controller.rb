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
  # before_filter :confirm_current_user
  after_filter :user_activity

  def confirm_current_user
    not_accessible = ["conversations", "profiles", "characteristics", "messages", "friendships"]
    redirect_to root_path if (!current_user && not_accessible.include?(controller_name))
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

  def after_sign_in_path_for(resource)
    if current_user.showcase
      intro_info_path
    elsif current_user.peer_counselor
      recommendations_path
    else
      session["user_return_to"] || conversations_path
    end
    # session["user_return_to"] request.env['omniauth.origin'] || stored_location_for(resource)
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  def build_query
    @search = Profile.search(params[:q])
    @search.build_sort if @search.sorts.empty?
    # @profiles = @search.result(distinct: true).reject{ |p| p.user == current_user}.select { |p| !current_user.block_exists?(p.user) }
    @profiles = order_preferences(@search.result(distinct: true).reject{ |p| p.user == current_user}).select { |p| !current_user.block_exists?(p.user) }
    @profiles = put_peer_counselor_first(@profiles) if !current_user.peer_counselor

    @num_profiles = @profiles.count
    @profiles.paginate(page: params[:page], per_page: 15)
  end

  def order_preferences(search_query)
    if params[:preferences]
      @sorted_preferences = Hash[params[:preferences].sort_by{|k, v| v}.reverse]
      puts "sorted_preferences"
      puts @sorted_preferences
      char_ids = params[:q][:characteristics_id_in_any]
      search_chars = build_search_chars(char_ids)
      @sorted_preferences.each do |category, rank|
        # ignore rank 0
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
    return params[:q][:s]["0"][:name] if params[:q]
    return ""
  end

  def query_all_counselors?
    return params[:q][:user_peer_counselor_true] == "1" if params[:q]
  end
end
