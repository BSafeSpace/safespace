class StaticPagesController < ApplicationController
  def home
  end
  
  def about
    render "about"
  end
  
  def contact
    render "contact"
  end
  
end
