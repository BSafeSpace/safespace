class ConfirmationsController < Devise::ConfirmationsController

  private

  def after_confirmation_path_for(resource_name, resource)
  	sign_in(resource)
    intro_info_path
  end

end