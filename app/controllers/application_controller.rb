class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :sign_in_user_if_login_token

  def index
  end

private

  def sign_in_user_if_login_token
    if params[:login_token]
      user = User.find_by_login_token(params[:login_token])

      # Destroy any existing user sessions
      sign_out current_user if current_user && current_user != user

      # Create new user session
      sign_in user
    end
  end

end
