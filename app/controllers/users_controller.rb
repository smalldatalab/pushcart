class UsersController < ApplicationController
  before_action :set_user, except: [ :thank_you_for_registering,
                                     :login_token_expired,
                                     :new_login_token ]

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:notice] = 'Your settings were successfully updated.'
      redirect_to action: "account_confirmation"
    else
      flash[:error] = @user.errors
      render action: "edit"
    end
  end

  def thank_you_for_registering
  end

  def account_confirmation
  end

  def change_settings
  end

  def log_out
    sign_out @user
    flash[:notice] = "You have successfully logged out."
    redirect_to :root
  end

  def login_token_expired
    @ref = params[:ref]

  end

  def new_login_token
    @return_path = params[:return_path]
    @user = User.find_by_email(params[:email])
    UserMailer.delay.resend_login_url(@user.id, @return_path).deliver
    flash[:notice] = "Thank you! Check your e-mail for your new login URL."
    redirect_to :back
  end

protected

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit( 
                                  :endpoint_email
                                )
  end

end