class UserMailer < BaseMailer

  ### Scraper ###

  def cannot_find_account(email, return_address)
    @email          = email
    @return_address = return_address
    mail(
        to: @email.from,
        subject: "[#{SITE_NAME}: Could not find your account] #{@email.subject}"
      )
  end

  def email_processed(user_id, email)
    set_user(user_id)
    @email = email
    mail(
        to: @user.email,
        subject: "[#{SITE_NAME}: Receipt processed] #{@email.subject}"
      )
  end

  def unprocessable_email(user_id, email)
    set_user(user_id)
    @email = email
    mail(
        to: @user.email,
        subject: "[#{SITE_NAME}: Not processed] #{@email.subject}"
      )
  end

  ### Authentication ###

  def getting_started(user_id)
    set_user(user_id)
    mail(
      to: @user.email,
      subject: "Getting started with #{SITE_NAME}"
      )
  end

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
      subject: "Weekly digest"
      )
  end

end
