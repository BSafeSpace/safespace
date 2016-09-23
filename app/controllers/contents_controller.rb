class ContentsController < ApplicationController
	before_action :set_content

	def set_content
		@content = Content.first
	end

	def index

	end

	def update
		@content = Content.first
		@content.update(content_params)
		@content_name = params[:content_name]
		@content_tag = params[:content_tag]
		flash[:notice] = "Content successfully updated"

		respond_to do |format|
			format.js { flash[:notice] = "Content successfully updated" }
			format.html { redirect_to :back }
		end
	end

	def content_params
		params.require(:content).permit(:slide_one, :slide_two, :slide_three, :slide_four, :terms_of_service, :about)
	end
end
