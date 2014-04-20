class FreshDirectScraper < ReceiptScraper

  def process_purchase
    @body_html = Nokogiri::HTML::Document.parse clean_body_html.gsub(/\=3D/,'=')

    build_purchase_object
    parse_items_and_add_to_purchase
    @purchase.raw_message = (Rails.env.development? || Rails.env.test?) ? @email.html_part.to_s : @email.raw_body

    return @purchase
  end

private

  def build_purchase_object
    @purchase = Purchase.new({
                              vendor:           'Fresh Direct',
                              sender_email:     @email.from.to_s,
                              total_price:      parse_order_total,
                              order_unique_id:  parse_order_number
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
            if child.text =~ /\t\t\t\$/
              return child.text.gsub(/(\t\t\t\$|\*)/, '')
            end
          end
        end
      end
    end
  end

  def parse_items_and_add_to_purchase
    tables = @body_html.xpath('//table')
    # Rails.logger.info '!!!!!!!!!!TABLES: #{tables}'
    purchase_tables = tables.map{ |t| t if matches_element_characteristic?(t['style'], 'padding:0;margin:0;border-collapse:collapse;border-spacing:0;border-style:none;') }
    # Rails.logger.info '!!!!!!!!!!PURCHASE TABLES: #{purchase_tables}'

    purchase_tables.each do |table|
      unless table.nil?
        table.children.each do |tbody|
          category = nil
          tbody.children.each do |tr|
            # Rails.logger.info '!!!!!!!!!!TR: #{tr}'
            item = Item.new(category: category) unless category.nil?
            tr.children.each do |td|
              if matches_element_characteristic?(td['style'], 'color:#f93;font-weight:bold;font-family:Verdana,Arial,sans-serif;font-size:12px;') || matches_element_characteristic?(td['style'], 'font-size:12;font-family:Verdana,Arial,sans-serif;color:rgb(255,153,51);font-weight:bold;')
                category = td.text
              elsif tr['valign'] == 'middle'
                case td['width']
                when '40' # Quantity
                  item.quantity = td.text
                when nil # Name & Description
                  name_and_description = td.text.strip
                  item.name, description = name_and_description.split(/\t\t\t\t\t\t/)
                  item.description = description[/\(.*?\)/].gsub(/(^\(|\)$)/, '') unless description.nil?
                when '70' # Price breakdown or additional information
                  if td.text =~ /(\(|\))/
                    item.price_breakdown = td.text.gsub(/(^\(\$|\)$)/, '')
                  elsif td.text =~ /S/
                    item.discounted = true
                  end
                when '60' # Total price
                  item.total_price = td.text.gsub(/\$/, '')
                end
              end
            end
            if item && !item.name.nil?
              @purchase.items << item
            end
          end
        end
      end
    end
  end

end

# e = FreshDirectScraper.new(Mail.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_one.eml')).process_purchase



