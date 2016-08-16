class TermsOfServiceController < ApplicationController
  def new
  	@terms_of_service = TermsOfService.new
  end

  def create
  	  @terms_of_service = TermsOfService.new(params[:terms_of_service])
	  if @terms_of_service.valid?
	    # TODO send terms_of_service here
	    redirect_to intro_sign_liability_path
	  else
	    render :action => 'new'
	  end
  end

end