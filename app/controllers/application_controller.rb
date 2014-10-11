class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
  end

protected

  def set_user_or_redirect
    @user = current_user
    # if @user.nil?
    #   flash[:notice] = "You do not have permission to access this page."
    #   redirect_to :root
    # end
  end

end
