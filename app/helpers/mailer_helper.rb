module MailerHelper

  def url_with_login_token(user, url, params=nil)
    token = user.return_or_set_login_token
    url = root_url if url.blank?
    if params
      return raw("#{url}?user_email=#{user.email}&user_token=#{user.authentication_token}&#{params}")
    else
      return raw("#{url}?user_email=#{user.email}&user_token=#{user.authentication_token}")
    end
  end

  def beautify_numerical_output(num, na=false)
    if na && num == 0.0
      return 'N/A'
    else
      return num.blank? ? 'N/A' : "%g" % num
    end
  end

end
