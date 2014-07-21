class BaseMailer < ActionMailer::Base
  add_template_helper MailerHelper
  default from: "the.good.folks@#{SITE_URL}"

private

  def set_user(user_id)
    @user = User.find(user_id)
  end

end
