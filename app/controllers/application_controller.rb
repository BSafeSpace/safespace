require 'csv'
require 'ostruct'
require 'will_paginate/array'
class ApplicationController < ActionController::Base
  include CharacteristicsHelper
  include FriendshipsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_filter :toggle_appear_offline
  before_filter :confirm_current_user

  after_filter :user_activity

  helper_method :get_chars

  def get_chars(conversation)
    @other_user = conversation.get_other_user(current_user)
    @other_user_chars = @other_user.profile.characteristics 
    @mental_health = @other_user_chars.where('category = ?', "mental_health")
    @age = @other_user.profile.age
    @gender = @other_user_chars.where('category = ?', "gender")
    @religion = @other_user_chars.where('category = ?', "religion")
    @ethnicity = @other_user_chars.where('category = ?', "ethnicity")
    @academic_focus = @other_user_chars.where('category = ?', "academic_focus")
    return OpenStruct.new(mental_health: @mental_health, 
                          age: @age, 
                          gender: @gender, 
                          religion: @religion, 
                          ethnicity: @ethnicity,
                          academic_focus: @academic_focus)
  end

  def confirm_current_user
    not_accessible = ["conversations", "profiles", "characteristics", "messages", "friendships"]
    if !current_user && not_accessible.include?(controller_name)
      redirect_to root_path
    end
  end

  def toggle_appear_offline
    @user = current_user
    if @user
      @user.appear_offline = !@user.appear_offline
      @user.save!
    end
    redirect_to :back
  end
  
  private

  def user_activity  
    if @current_user
  	 @current_user.try(:touch)
    end
  end

  def build_query
    @search = Profile.search(params[:q])
    @search.build_sort if @search.sorts.empty?
    @profiles = @search.result(distinct: true)
    @profiles = @profiles.reject{ |p| p.user == current_user}
    @profiles = order_preferences(@profiles)
    @num_profiles = @profiles.count
    if !current_user.peer_counselor
      @profiles = put_peer_counselor_first(@profiles)
    end
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
    peer_counselor_prof = User.where("peer_counselor = ?", true).first.profile
    search_query = search_query.reject{ |p| p == peer_counselor_prof }

    for i in 0..search_query.count
      search_query.insert(i, peer_counselor_prof) if i % 15 == 0
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
