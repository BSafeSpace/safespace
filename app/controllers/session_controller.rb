class SessionsController < Devise::SessionsController

  def destroy
    current_user.update_attribute(:last_sign_out_at, Time.now)
    super
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.banned?
      sign_out resource
      flash[:error] = "This account has been suspended for violation of...."
      root_path
    else
      super
    end
   end

  "You have been blocked by at least three users. This is to protect students from harmful or inappropriate comments. If you feel this is a mistake, please e-mail safespacebear@gmail.com with the subject headline 'Mistakenly blocked.'"

end