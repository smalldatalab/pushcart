require 'weekly_email_digester'
WeeklyDigestMailerJob = Struct.new(:user) do

  def self.perform
    deliver_digest(weekly_digest)
    destroy_emails_marked_for_destruction
  end

private 

  def weekly_digest
    WeeklyEmailDigester.build(user)
  end

  def deliver_digest(digest)
    UserMailer.weekly_digest(user, digest).deliver
  end

  def destroy_emails_marked_for_destruction
    emails_marked_for_destruction.destroy_all
  end

  def emails_marked_for_destruction
    user_inbound_emails.older_than_a_month
  end

  def user_inbound_emails
    user.messages
  end
  
end
