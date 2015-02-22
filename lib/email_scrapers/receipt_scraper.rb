class ReceiptScraper

  def initialize(email)
    @email = email
  end

  def clean_body_html
    @email.raw_html.gsub(/(\r|\n|\=\r|\=\n)/, '').gsub('\"', '"').gsub(/\A\p{Space}*/, ' ')
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

    clean = el.dup

    # Convert border properties to standard format

      if clean =~ /(border)/ #|margin|padding)/
        prefixes = ['border'] #, 'margin', 'padding']
        suffixes = ['-top', '-bottom', '-right', '-left', '']

        prefixes.each do |prefix|
          suffixes.each do |suffix|
            property_name = "#{prefix}#{suffix}"

            dirty_strings = clean.scan(/#{Regexp.escape property_name}:\s?\S+\s[^(;|,|\Z|$)]*/).flatten

            dirty_strings.each do |dirty_string|

              # Handle !important
              if dirty_string =~ /!important/
                dirty_string = dirty_string.gsub(/(|\s)!important/, '')
                has_important = true
              end

              dirty_string = dirty_string.gsub(/#{Regexp.escape property_name}:\s?/, '')              

              props = dirty_string.split

              prop_suffixes = ['-width', '-style', '-color']

              clean_string = ''

              props.each_with_index do |prop, index|
                new_prop = "#{property_name}#{prop_suffixes[index]}:#{prop}"

                new_prop << ' !important' if has_important

                clean_string << new_prop
              end

              clean = clean.gsub(/#{Regexp.escape property_name}:\s?\S+\s[^(;|,|\Z|$)]*/, clean_string)
            end
          end
        end
      end

    # Remove spaces & px
      clean = clean.gsub(/(\s|px)/, '')

    # Remove leading 0 from decimal values
      clean = clean.gsub(/0\./, '.')

    # Downcase
      clean = clean.downcase

    # Chop off ;s
      clean = clean.gsub(/;/, '')

    # Convert RGBs to hexes
      rgbs = clean.scan(/rgb\([^\)]*\)/).flatten

      unless rgbs.empty?
        rgbs.each do |rgb|
          values  = rgb.scan(/\(([^\)]+)\)/)[0][0].split(',')
          hex     = Color::RGB.new(values[0].to_f, values[1].to_f, values[2].to_f).hex

          clean = clean.gsub(rgb, "##{hex}")
        end
      end

    # Eliminate all the color:#00000s (which sometimes killed)

      clean = clean.gsub(/color:(\s*|)#000000/, '')

    return clean
  end

end