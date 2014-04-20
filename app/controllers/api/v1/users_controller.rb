class Api::V1::UsersController < Api::V1::BaseController

  before_action :set_application

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

private

  def set_application
    # @application = 
  end

end
