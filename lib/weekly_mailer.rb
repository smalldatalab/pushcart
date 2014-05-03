class WeeklyMailer 

  def initialize(user)
    @user = user
  end

  def deliver
    UserMailer.weekly_digest(@user).deliver
    delete_past_emails
  end

  handle_asynchronously :deliver

  private 

  def delete_past_emails 
    @user.inbound_emails.before_last_four_weeks.delete_all
  end
end
