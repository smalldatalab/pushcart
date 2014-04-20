module ApplicationHelper

  def path_with_login_token(user, path)
    token = user.return_or_set_login_token
    path = root_path if path.blank?
    "#{path}?login_token=#{user.login_token}"
  end

end
