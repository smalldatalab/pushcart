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
      return clean_string(element) == clean_string(characteristic_string)
    end
  end

  def clean_string(el)
    # Remove spaces & px
    clean = el.gsub(/(\s|px)/, '')
    # Downcase
    clean = clean.downcase
    #Chop off trailing ;
    clean = clean.gsub(/;$/, '')

    return clean
  end

end