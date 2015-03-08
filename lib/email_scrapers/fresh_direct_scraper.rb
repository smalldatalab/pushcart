class FreshDirectScraper < ReceiptScraper

  def process_purchase
    @body_html = Nokogiri::HTML::Document.parse clean_body_html.gsub(/\=3D/,'=')

    build_purchase_object
    parse_items_and_add_to_purchase
    @purchase.raw_message = @email.raw_html

    return @purchase
  end

private

  def build_purchase_object
    @purchase = Purchase.new({
                              vendor:           'Fresh Direct',
                              sender_email:     @email.from.to_s,
                              total_price:      parse_order_total,
                              order_unique_id:  parse_order_number,
                              order_date:       @email.date ? @email.date : nil
                            })
  end

  def parse_order_number
    @body_html.xpath('//span').each do |span|
      if matches_element_characteristic?(span['style'], 'color:#FF9933')
        return span.parent.text.gsub('ORDER INFORMATION for ORDER NUMBER ', '')
      end
    end
  end

  def parse_order_total
    @body_html.xpath('//td').each do |td|
      if matches_element_characteristic?(td['style'], 'font-family:Verdana,Arial,sans-serif;font-size:12px;') && td['valign'] == 'top'
        if td.text =~ /ORDER TOTAL/
          td.children.each do |child|
            if child.text =~ /\$/
              return child.text.gsub(/(^.*\$|\*)/, '')
            end
          end
        end
      end
    end
  end

  def parse_items_and_add_to_purchase
    category = nil
    @body_html.xpath('//tr').each do |tr|
      item_hash = {category: category} unless category.nil?
      tr.children.each do |td|
        if matches_element_characteristic?(td['style'], 'color:#f93;font-weight:bold;font-family:Verdana,Arial,sans-serif;font-size:12px;') || matches_element_characteristic?(td['style'], 'font-size:12;font-family:Verdana,Arial,sans-serif;color:rgb(255,153,51);font-weight:bold;')
          category = td.text
        elsif tr['valign'] == 'middle'
          case td['width']
          when '40' # Quantity
            item_hash[:quantity] = td.text
          when nil # Name & Description
            name_and_description = td.text.strip
            name, description = name_and_description.split(/\t\t\t\t\t\t/)
            item_hash[:name] = name.strip
            item_hash[:description] = description[/\(.*?\)/].gsub(/(^\(|\)$)/, '') if description
          when '70' # Price breakdown or additional information
            if td.text =~ /(\(|\))/
              item_hash[:price_breakdown] = td.text.gsub(/(^\(\$|\)$)/, '')
            elsif td.text =~ /S/
              item_hash[:discounted] = true
            end
          when '60' # Total price
            item_hash[:total_price] = td.text.gsub(/\$/, '')
          end
        end
      end
      if item_hash && item_hash[:name] && item_hash[:quantity] && item_hash[:total_price]

        unless item_hash[:name] =~ /(Group\sDiscount|with\scoupon)/i
          @purchase.itemizables << build_itemizable(item_hash)
        end

        item_hash = {}
      end
    end
  end

end
