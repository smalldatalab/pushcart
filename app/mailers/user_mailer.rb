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

  def welcome(user_id)
    set_user(user_id)
    mail(
          to: @user.email,
          subject: "Welcome to #{SITE_NAME.titleize}!"
        )
  end

  def new_pushcart_endpoint_email(user_id)
    set_user(user_id)
    mail(
          to: @user.email,
          subject: "[Important] Get your data auto-magically with your #{SITE_NAME.titleize} e-mail!"
        )
  end

  def onboarding_complete(user_id)
    set_user(user_id)
    mail(
          to: @user.email,
          subject: "Your #{SITE_NAME.titleize} account in a nutshell."
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
      bcc: 'michael@aqua.io',
      subject: "Your Weekly Pushcart Digest | #{american_date_format(digest.start_date)} - #{american_date_format(digest.end_date)}"
      )
  end

  ### Replacement Suggestion ###

  def replacement_suggestion(item)
    @item = item
    @user = item.user
    @swap = item.swap
    mail(
      to: @user.email,
      bcc: 'michael@aqua.io',
      subject: "A suggested item substitution for your next purchase!"
      )
  end

  ### Message Confirmation ###

  def message_received(message_id)
    @message = Message.find(message_id)
    mail(
      to: @message.from,
      subject: "[Pushcart] #{@message.subject}"
      )
  end 

  def american_date_format(date)
    date.strftime("%b %-d")
  end

end
