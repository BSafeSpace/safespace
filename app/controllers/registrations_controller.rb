class RegistrationsController < Devise::RegistrationsController

	def create
		super
		if params[:user][:passcode] == 
			resource.update(peer_counselor: true)
		end
	end

	protected

	def after_sign_up_path_for(resource)
		intro_info_path # Or :prefix_to_your_route
	end
end
