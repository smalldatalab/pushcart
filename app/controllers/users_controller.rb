class UsersController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  before_action :set_user_or_redirect, except: [ :thank_you_for_registering,
                                                 :login_token_expired,
                                                 :new_login_token ]

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:notice] = 'Your settings were successfully updated.'
      redirect_to action: 'my_account'
    else
      flash[:error] = @user.errors
      redirect_to :back
    end
  end

  def thank_you_for_registering
  end

  def account_confirmation
  end

  def my_account
  end

  def change_settings
  end

  def log_out
    sign_out @user
    flash[:notice] = 'You have successfully logged out.'
    redirect_to :root
  end

  def login_token_expired
    @ref = params[:ref]

  end

  def new_authentication_token
    @return_path = params[:return_path]
    @user = User.find_by_email(params[:email])
    UserMailer.delay.resend_login_url(@user.id, @return_path)
    flash[:notice] = "Thank you! Check your e-mail for your new login URL."
    redirect_to :back
  end

  def edit_household
    @user.household_members.build
  end

protected

  def set_user_or_redirect
    @user = current_user
    # if @user.nil?
    #   flash[:notice] = "You do not have permission to access this page."
    #   redirect_to :root
    # end
  end

  def user_params
    params.require(:user).permit( 
                                  :endpoint_email,
                                  :mission_statement,
                                  household_members_attributes: [
                                                                  :id,
                                                                  :age,
                                                                  :gender,
                                                                  :_destroy
                                                                ]
                                )
  end

end