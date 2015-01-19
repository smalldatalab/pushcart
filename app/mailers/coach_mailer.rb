class CoachMailer < BaseMailer

  def new_team_member(membership_id)
    @membership = Membership.find(membership_id)
    mail(
        to: @membership.coach.email,
        subject: "#{@membership.user.email} has joined your Pushcart team!"
      )
  end

end
