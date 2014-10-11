module MailerHelper

  def url_with_login_token(user, url)
    token = user.return_or_set_login_token
    url = root_url if url.blank?
    return raw("#{url}?user_email=#{user.email}&user_token=#{user.authentication_token}")
  end

  def vendor_search_link(item_name, vendor)
    case vendor
    when 'Fresh Direct'
      "https://www.freshdirect.com/search.jsp?searchParams=#{format_search_string(item_name)}"
    when 'Peapod'
      'https://www.peapod.com/processShowBrowseAisles.jhtml'
    when 'Instacart'  
      "https://www.instacart.com/store/whole-foods/search/#{format_search_string(item_name, '%20')}"
    else
      search_string = format_search_string("#{vendor} #{item_name}")
      "https://www.google.com/search?q=#{search_string}"
    end
  end

  def format_search_string(search_string, space_filler='+')
    search_string.urlize.gsub('-', space_filler)
  end

  def beautify_numerical_output(num, na=false)
    if na && num == 0.0
      return 'N/A'
    else
      return num.blank? ? 'N/A' : "%g" % num
    end
  end

end
