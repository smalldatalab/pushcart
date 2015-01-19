class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @user = User.new
    if Coach.find_by_id params[:coach_id]
      @coach_id = params[:coach_id]
    end
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
