class StaticPagesController < ApplicationController
  def home
  end
  
  def welcome
    @user = current_user
  end
  
  def about
    render "about"
  end
  
  def contact
    render "contact"
  end
  
end
