class StaticPagesController < ApplicationController
  before_action :set_content

  def set_content
  	@content = Content.first
  end

  def home
  end
  
  def about
    render "about"
  end
  
  def contact
    render "contact"
  end
  
end
