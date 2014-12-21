class Api::V1::MessagesController < Api::V1::BaseCoachController

  before_action :set_user

  def index
    if params[:range_start] || params[:range_end]
      range_start = params[:range_start] ? DateTime.parse(params[:range_start]) : DateTime.parse("2014-01-01")
      range_end   = params[:range_end] ? DateTime.parse(params[:range_end]) : DateTime.now
      @messages = @user.messages.with_coach(@coach.id).where(created_at: range_start..range_end)
    else
      @messages = @user.messages.with_coach(@coach.id)
    end
  end

  def show
    @message = @user.messages.with_coach(@coach.id).find params[:id]
  end

  def create

  end

private

  def message_params

  end

end
