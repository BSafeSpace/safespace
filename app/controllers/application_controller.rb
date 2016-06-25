require 'csv'
require 'ostruct'
require 'will_paginate'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_filter :toggle_appear_offline

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

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end
end
