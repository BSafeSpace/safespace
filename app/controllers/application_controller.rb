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

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end
end
