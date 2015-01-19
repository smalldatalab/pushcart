class Api::V1::MembershipsController < Api::V1::BaseCoachController

  before_action :set_coach

  def invite
    if @coach.members.find_by_email params[:email]
      render json: ["#{params[:email]} is already a member!"], status: :unprocessable_entity
    elsif EmailValidator.valid?(params[:email])
      if UserMailer.delay.join_team_request(params[:email], @coach.id)
        render json: ["Invite sent to #{params[:email]}."], status: :ok
      else
        render json: ["Error processing invitation."], status: :unprocessable_entity
      end
    else
      render json: ["Not a valid e-mail address!"], status: :unprocessable_entity
    end
  end

private

  def member_params

  end

end
