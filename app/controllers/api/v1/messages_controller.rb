class Api::V1::MessagesController < Api::V1::BaseController

  before_action :set_user

  def index
    if params[:range_start] || params[:range_end]
      range_start = params[:range_start] ? DateTime.parse(params[:range_start]) : DateTime.parse("2014-01-01")
      range_end   = params[:range_end] ? DateTime.parse(params[:range_end]) : DateTime.now
      @messages = @user.messages.where(created_at: range_start..range_end)
    else
      @messages = @user.messages
    end
  end

  def show
    @message = @user.messages.find params[:id]
  end

end
