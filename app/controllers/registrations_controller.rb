class RegistrationsController < Devise::RegistrationsController

	def create

		super do |resource|
			puts 'errors:'
			puts resource.errors[:email]
			if params[:user][:email]
				puts 'email exists'
				resource.errors.delete(:email)
			end
		end

		puts 'create action'
		if params[:user][:passcode] == ENV['COUNSELOR_PASSCODE']
			resource.update(peer_counselor: true, signed_liability: true, completed_bio: true, done_tut_add_friend: true, done_tut_filter: true)
			puts 'updated as peer counselor'
		end

	end

	protected

	def after_sign_up_path_for(resource)
		intro_info_path # Or :prefix_to_your_route
	end
end
