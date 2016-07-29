class RegistrationsController < Devise::RegistrationsController

	def create
		super
		puts 'create action'
		if params[:user][:passcode] == ENV['COUNSELOR_PASSCODE']
			resource.update(peer_counselor: true)
			puts 'updated boolean'
		end
	end

	protected

	def after_sign_up_path_for(resource)
		intro_info_path # Or :prefix_to_your_route
	end
end
