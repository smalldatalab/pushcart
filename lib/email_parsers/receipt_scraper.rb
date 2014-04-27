class ReceiptScraper

  def initialize(email)
    @email = email
  end

  def clean_body_html
    @email.raw_html.gsub(/(\r|\n|\=\r|\=\n)/, '')
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