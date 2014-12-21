class Api::V1::BaseCoachController < Api::V1::BaseController
  before_action :doorkeeper_authorize!

  before_action :set_coach

private

  def set_user
    user_id = params[:user_id] || params[:id]
    @user = @coach.members.find user_id
  end

end
