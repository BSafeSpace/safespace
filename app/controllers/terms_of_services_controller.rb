class TermsOfServicesController < ApplicationController
	before_action :set_content

	def set_content
		@content = Content.first
	end
	
  def new
  	@terms_of_service = TermsOfService.new
  end

  def create
	@terms_of_service = TermsOfService.new(terms_of_service_params)
		if @terms_of_service.valid?
		# TODO send terms_of_service here
		puts params
		sign_liability
	else
		render 'new'
	end
  end

  def sign_liability
	@user = User.find current_user.id
	@user.update(signed_liability: true)
	redirect_to profiles_path
  end

  private

  def terms_of_service_params
  	params.require(:terms_of_service).permit(:terms_of_service)
  end

end