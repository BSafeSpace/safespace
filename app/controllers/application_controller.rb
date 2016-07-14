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

  helper_method :get_chars

  def get_chars(conversation)
    other_user = conversation.get_other_user(current_user)
    characteristics = other_user.profile.characteristics 
    return OpenStruct.new(mental_health: characteristics.where('category = ?', "mental_health"), 
                          age: other_user.profile.age, 
                          gender: characteristics.where('category = ?', "gender"), 
                          religion: characteristics.where('category = ?', "religion"), 
                          ethnicity: characteristics.where('category = ?', "ethnicity"),
                          academic_focus: characteristics.where('category = ?', "academic_focus"))
  end

  def confirm_current_user
    not_accessible = ["conversations", "profiles", "characteristics", "messages", "friendships"]
    redirect_to root_path if (!current_user && not_accessible.include?(controller_name))
  end

  def toggle_appear_offline
    if current_user
      current_user.appear_offline = !current_user.appear_offline
      current_user.save!
    end

    redirect_to :back
  end
  
  private

  def user_activity  
  	 @current_user.try(:touch) if @current_user
  end

  def build_query
    @search = Profile.search(params[:q])
    @search.build_sort if @search.sorts.empty?
    @profiles = order_preferences(@search.result(distinct: true).reject{ |p| p.user == current_user})
    @num_profiles = @profiles.count
    @profiles = put_peer_counselor_first(@profiles) if !current_user.peer_counselor
    @profiles.paginate(page: params[:page], per_page: 15)
  end

  def order_preferences(search_query)
    if params[:preferences]
      search_query = put_preference_first(search_query, params[:preferences][:fourth])
      search_query = put_preference_first(search_query, params[:preferences][:third])
      search_query = put_preference_first(search_query, params[:preferences][:second])
      search_query = put_preference_first(search_query, params[:preferences][:first])
    end

    return search_query
  end

  def put_preference_first(search_query, name)
    characteristic = Characteristic.where('name = ?', name).first
    
    if characteristic
      matching_profiles = search_query.select { |profile| profile.characteristics.include? characteristic }
      search_query = search_query.reject!{ |profile| profile.characteristics.include? characteristic }
      search_query = matching_profiles + search_query
    end

    return search_query
  end

  def put_peer_counselor_first(search_query)
    peer_counselors = User.where("peer_counselor = ?", true)
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

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end
end
