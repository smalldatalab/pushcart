class UserMailer < BaseMailer

  ### Scraper ###

  def cannot_find_account(email, return_address)
    @email          = email
    @return_address = return_address
    mail(
        to: @email.from,
        subject: "[#{SITE_NAME.titleize}: Could not find your account] #{@email.subject}"
      )
  end
 
  def email_processed(user_id, email)
    set_user(user_id)
    @email = email
    mail(
        to: @user.email,
        subject: "[#{SITE_NAME.titleize}: Receipt processed] #{@email.subject}"
      )
  end

  def unprocessable_email(user_id, email)
    set_user(user_id)
    @email = email
    mail(
        to: @user.email,
        subject: "[#{SITE_NAME.titleize}: Not processed] #{@email.subject}"
      )
  end

  ### Onboarding ###

  def getting_started(user_id)
    set_user(user_id)
    mail(
      to: @user.email,
      subject: "Getting started with #{SITE_NAME.titleize}"
      )
  end

  def set_mission_and_household(user_id)
    set_user(user_id)
    mail(
          to: @user.email,
          subject: "Just one last thing to get the most out of #{SITE_NAME.titleize}!"
        )
  end

  ### Authentication ###

  def resend_login_url(user_id, url=nil)
    set_user(user_id)
    @url  = url
    mail(
      to: @user.email,
      subject: "Your login request"
      )
  end

  ### Weekly Digest ###

  def weekly_digest(user, digest)
    @user = user
    @digest = digest
    mail(
      to: @user.email,
      subject: "Your Weekly PushCart Digest #{Date.today} - #{Date.today + 6}"
      )
  end

  ### Message Confirmation ###

  def message_received(message)
    @message = message
    mail(
      to: @message.from,
      subject: "[Pushcart] #{@message.subject}"
      )
  end 
  
end
