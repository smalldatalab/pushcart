module ApplicationHelper

  def path_with_login_token(user, path)
    token = user.return_or_set_login_token
    path = root_path if path.blank?
    return raw("#{path}?user_email=#{user.email}&user_token=#{user.authentication_token}")
  end

### Devise AJAX helpers

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
