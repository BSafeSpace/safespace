class ResourcesController < ApplicationController
  def index
  	@resources = Resource.order("position")
  end

  def new
  	@resource = Resource.new
  	respond_to do |format|
  		format.html { redirect_to resources_url }
  		format.js
  	end
  end

  def create
  	@resource = Resource.create! resource_params
  	respond_to do |format|
  		format.html { redirect_to resources_url }
  		format.js
  	end
  end

  def edit
  	@resource = Resource.find params[:id]
  	respond_to do |format|
  		format.html
  		format.js
  	end
  end

  def update
  	@resource = Resource.find params[:id]
  	@resource.update(resource_params)
  	respond_to do |format|
  		format.html { redirect_to resources_url }
  		format.js
  	end
  end

  def destroy
  	@resource = Resource.destroy params[:id]
  	respond_to do |format|
  		format.html { redirect_to resources_url }
  		format.js
  	end
  end

  def sort
    params[:resource].each_with_index do |id, index|
      Resource.where(id: id).update_all({position: index+1})
    end
    render nothing: true
  end

  private

  def resource_params
	params.require(:resource).permit(:name, :description, :url)
  end
end
