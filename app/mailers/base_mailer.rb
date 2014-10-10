class BaseMailer < ActionMailer::Base
  add_template_helper MailerHelper
  default from: "\"Pushcart\" <info@#{SITE_URL}>"

private

  def set_user(user_id)
    @user = User.find(user_id)
  end

  def endpoint_reply_to
    "\"Your Pushcart forwarding address\" <#{@user.endpoint_email_with_uri}>"
  end

end
