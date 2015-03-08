class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env['omniauth.auth'], current_user)

    if @user.persisted?
      flash[:notice] = 'You have successfully registered with Gmail!'
      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      flash[:notice] = 'There was an error authenticating your Gmail account.'
      redirect_to root_path
    end
  end

  def after_omniauth_failure_path_for(resource)
    flash[:notice] = 'There was an error authenticating your Gmail account.'
    return root_path
  end
end