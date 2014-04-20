class Api::V1::BaseController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :set_api_version

private

  def set_api_version
    @api_version = "v1"
  end

  def set_user
    @user = User.find params[:user_id]
  end

end
