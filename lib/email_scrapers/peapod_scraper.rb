class PeapodScraper < ReceiptScraper

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
                              vendor:           'Peapod',
                              sender_email:     @email.from.to_s,
                              total_price:      parse_order_total,
                              order_unique_id:  parse_order_number,
                              order_date:       @email.date ? @email.date : nil
                            })
  end

  def parse_order_number
    return @email.subject.gsub(/^.*Order\sConfirmation\s/, '')
  end

  def parse_order_total
    @body_html.xpath('//td').each do |td|
      if td.text =~ /Total:/
        unless td.next.nil?
          if matches_element_characteristic?(td.next['align'], 'right') && matches_element_characteristic?(td.next['valign'], 'middle')
            return td.next.text.gsub(/(\$)/, '')
          end
        end
      end
    end
  end

  def parse_items_and_add_to_purchase
    @body_html.xpath('//table').each do |table|
      item_parser_v1 table
    end

    # v1 - Prior to 8/24/2014
    if @purchase.items.empty?
      @body_html.xpath('//table').each do |table|
        table.children.each do |tbody|
          item_parser_v1 tbody
        end
      end
    end
  end

  def item_parser_v1(node_set)
    if node_set.text =~ /^Item/
      category = nil
      node_set.children.each do |tr|
        if matches_element_characteristic?(tr['bgcolor'], '#EEEEEE')
          # Filter out non-grocery items
          if tr.text =~ /(Laundry|Home|Garden|Paper|Cleaning)/
            category = nil
          else
            category = tr.text
          end
        elsif !category.nil?
          item_hash = {category: category} unless category.nil?
          tr.children.each_with_index do |td, index|
            case index
            when 0 # Item name
              item_hash[:name] = td.text.strip
            when 1 # Description (Size)
              item_hash[:description] = td.text.strip
            when 2 # Quantity
              item_hash[:quantity] = td.text
            when 3 # Item Price
              item_hash[:price_breakdown] = "#{td.text}/ea"
            when 4 # Total Price
              item_hash[:discounted] = true if td.text =~ /\=C2\=A0/
              item_hash[:total_price] = td.text.gsub(/\=C2\=A/, '')
            end
          end
          if item_hash && item_hash[:name]
            @purchase.itemizables << build_itemizable(item_hash)
          end
        end
      end
    end
  end

end
