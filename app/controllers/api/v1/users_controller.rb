class Api::V1::UsersController < Api::V1::BaseCoachController

  before_action :set_user, only: :show

  def index
    @users = @coach.members
  end

  def show
  end

end
