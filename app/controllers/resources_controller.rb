class ResourcesController < ApplicationController
  def index
  	@resources = Resource.all
  end

  def new
  	@resource = Resource.new
  end

  def create
  	@resource = Resource.create! resource_params
  	respond_to do |format|
  		format.html
  		format.js
  	end
  end

  def edit
  end

  def destroy
  end

  private

  def resource_params
	params.require(:resource).permit(:name, :description, :url)
  end
end
