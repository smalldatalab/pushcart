class Api::V1::BaseController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :set_api_version

private

  def set_coach
    @coach = Coach.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def set_api_version
    @api_version = 'v1'
  end

end
