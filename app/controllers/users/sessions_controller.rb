class Users::SessionsController < Devise::SessionsController
  def create
    user = User.find_by(email: params[:user][:email])
    if user.nil?
      redirect_to new_user_registration_path
    else
      if user.valid_password?(params[:user][:password]) && user.deleted_at.nil?
        sign_in user
        redirect_to root_path
      else
        redirect_to new_user_session_path
      end
    end
  end
end