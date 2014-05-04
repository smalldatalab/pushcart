class UserMailer < ActionMailer::Base
  add_template_helper MailerHelper
  default from: "the.good.folks@#{SITE_URL}"

  ### Scraper ###

  def cannot_find_account(email)
    @email = email
    mail(
        to: @email.from,
        subject: "[#{SITE_NAME}: Could not find your account] #{@email.subject}"
      )
  end

  def email_processed(user, email)
    @user = user
    @email = email
    mail(
        to: @user.email,
        subject: "[#{SITE_NAME}: Receipt processed] #{@email.subject}"
      )
  end

  def unprocessable_email(user, email)
    @user = user
    @email = email
    mail(
        to: @user.email,
        subject: "[#{SITE_NAME}: Not processed] #{@email.subject}"
      )
  end

  ### Authentication ###

  def getting_started(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Getting started with #{SITE_NAME}"
      )
  end

  def resend_login_url(user, url=nil)
    @user = user
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
