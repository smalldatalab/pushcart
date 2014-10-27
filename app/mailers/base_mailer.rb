class BaseMailer < ActionMailer::Base
  add_template_helper MailerHelper
  default from: "\"Pushcart\" <info@#{EMAIL_URI}>"

private

  def set_user(user_id)
    @user = User.find(user_id)
  end

  def user_endpoint_reply_to
    "\"Your Pushcart forwarding address\" <#{@user.endpoint_email_with_uri}>"
  end

end
