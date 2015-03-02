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
    # tables = @body_html.xpath('//table')

    category = nil
    @body_html.xpath('//tr').each do |tr|
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
            name, description = name_and_description.split(/\t\t\t\t\t\t/)
            item.name = name.strip
            item.description = description[/\(.*?\)/].gsub(/(^\(|\)$)/, '') if description
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
      if item && item.name && item.quantity && item.total_price
        # p item.attributes.delete_if { |k,v| ['id', 'purchase_id', "created_at", "updated_at", "ntx_api_nutrition_data", "ntx_api_metadata", "color_code"].include? k }
        @purchase.items << item
      end
    end

    # tables.map{ |t| p t.children, t['style'] }#if matches_element_characteristic?(t['style'], 'padding:0;margin:0;border-collapse:collapse;border-spacing:0;border-style:none;') }
    # purchase_tables = tables.map{ |t| t if matches_element_characteristic?(t['style'], 'padding:0;margin:0;border-collapse:collapse;border-spacing:0;border-style:none;') }.compact

    # purchase_tables.each do |table|
    #   table.children.each do |tbody|
    #     category = nil
    #     tbody.children.each do |tr|
    #       item = Item.new(category: category) unless category.nil?
    #       tr.children.each do |td|
    #         # p td['valign']
    #         if matches_element_characteristic?(td['style'], 'color:#f93;font-weight:bold;font-family:Verdana,Arial,sans-serif;font-size:12px;') || matches_element_characteristic?(td['style'], 'font-size:12;font-family:Verdana,Arial,sans-serif;color:rgb(255,153,51);font-weight:bold;')
    #           category = td.text
    #           p category
    #         elsif tr['valign'] == 'middle'
    #           p "!!!!!!!!!!!!!!"
    #           case td['width']
    #           when '40' # Quantity
    #             p td.text
    #             item.quantity = td.text
    #           when nil # Name & Description
    #             name_and_description = td.text.strip
    #             name, description = name_and_description.split(/\t\t\t\t\t\t/)
    #             item.name = name.strip
    #             item.description = description[/\(.*?\)/].gsub(/(^\(|\)$)/, '') unless description.nil?
    #           when '70' # Price breakdown or additional information
    #             if td.text =~ /(\(|\))/
    #               item.price_breakdown = td.text.gsub(/(^\(\$|\)$)/, '')
    #             elsif td.text =~ /S/
    #               item.discounted = true
    #             end
    #           when '60' # Total price
    #             item.total_price = td.text.gsub(/\$/, '')
    #           end
    #         end
    #       end
    #       # p item
    #       if item && item.name && item.quantity && item.total_price
    #         p item.attributes.delete_if { |k,v| ['id', 'purchase_id', "created_at", "updated_at", "ntx_api_nutrition_data", "ntx_api_metadata", "color_code"].include? k }
    #         @purchase.items << item
    #       end
    #     end
    #   end
    # end
  end

end
