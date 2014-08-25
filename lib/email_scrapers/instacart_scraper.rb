class InstacartScraper < ReceiptScraper

  def process_purchase
    @body_html = Nokogiri::HTML::Document.parse clean_body_html.gsub(/\=3D/,'=')
    get_full_order_page_html

    build_purchase_object
    parse_items_and_add_to_purchase
    @purchase.raw_message = @email.raw_html

    return @purchase
  end

private

  def build_purchase_object
    @purchase = Purchase.new({
                              vendor:           'Instacart',
                              sender_email:     @email.from.to_s,
                              total_price:      parse_order_total,
                              order_unique_id:  parse_order_number
                            })
  end

  def get_full_order_page_html
    link = nil

    @body_html.css('a').each do |l|
      link = l["href"] if l.text =~ /see\s?\d*\smore\sitems/i
    end

    link = URI(link)
    redirect_location = Net::HTTP.get_response(link)['location']
    @body_html = Nokogiri::HTML(open(redirect_location.gsub(Regexp.new('#see-all'), '')))
  end

  def parse_order_number
    'N/A'
  end

  def parse_order_total
    return @body_html.css('tr.total td.amount')[0].children.first.text
  end

  def parse_items_and_add_to_purchase
    category = nil
    @body_html.css('table.delivered tbody').first.children.each do |tr|
      tr.children.each do |td|
        if td['class'] == 'section-head'
          category = td.text
        elsif td['class'] == 'order-item'
          item = Item.new(category: category) unless category.nil?
          td.css('.item-delivered').children.each do |item_attr|
            case item_attr['class']
            when 'item-name'
              item.name, item.description = item_attr.text.strip.split("\n")
            when 'item-price'
              item.price_breakdown = item_attr.text.strip
              quantity_and_price = item.price_breakdown.split(' × ')
              item.quantity = quantity_and_price[0]
              price = quantity_and_price[1].gsub(/\$/, '').to_f
              item.total_price = price * item.quantity
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

# e = FreshDirectScraper.new(Mail.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_one.eml')).process_purchase



