module MailerHelper

  def url_with_login_token(user, url)
    token = user.return_or_set_login_token
    url = root_url if url.blank?
    "#{url}?login_token=#{user.login_token}"
  end

end
