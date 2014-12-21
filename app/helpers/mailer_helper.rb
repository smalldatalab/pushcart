module MailerHelper

  def url_with_login_token(user, url)
    token = user.return_or_set_login_token
    url = root_url if url.blank?
    return raw("#{url}?user_email=#{user.email}&user_token=#{user.authentication_token}")
  end

  def beautify_numerical_output(num, na=false)
    if na && num == 0.0
      return 'N/A'
    else
      return num.blank? ? 'N/A' : "%g" % num
    end
  end

end
