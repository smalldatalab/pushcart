class MembershipsController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  before_action :set_user_or_redirect

  def create
    @membership = @user.memberships.new(membership_params)
    if @membership.save
      flash[:notice] = "You have now joined #{@membership.coach.name}'s team!"
      redirect_to controller: 'users', action: 'my_account'
    else
      flash[:error] = @membership.errors
      redirect_to :back
    end
  end

  def new
    @coach = Coach.find_by_id params[:coach_id]
    @membership = @user.memberships.new
  end

protected

  def membership_params
    params.require(:membership).permit(:coach_id)
  end

end