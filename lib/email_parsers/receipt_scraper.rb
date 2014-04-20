class ReceiptScraper

  def initialize(email)
    @email = email
  end

  def clean_body_html
    html = (Rails.env.development? || Rails.env.test?) ? @email.html_part.to_s : @email.raw_html
    html.gsub(/(\r|\n|\=\r|\=\n)/, '')
  end

private

  def matches_element_characteristic?(element, characteristic_string)
    if element.nil?
      return false
    else
      return element.gsub(/(\s|px)/, '') == characteristic_string.gsub(/(\s|px)/, '')
    end
  end

end