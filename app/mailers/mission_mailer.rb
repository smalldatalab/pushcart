class MissionMailer < BaseMailer
  default from: "set_your_mission@#{SITE_URL}"

  def set_mission(user_id)
    set_user(user_id)
    mail(
          to: @user.email,
          subject: "Set your household mission!"
        )
  end

  def new_mission(email, mission_statement)
    @mission_statement = mission_statement
    mail(
          to: email,
          subject: "You new Pushcart mission"
        )
  end

end
