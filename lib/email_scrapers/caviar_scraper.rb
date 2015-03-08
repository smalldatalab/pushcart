class CaviarScraper < ReceiptScraper

  def process_purchase
    @body_html = Nokogiri::HTML::Document.parse clean_body_html.gsub(/\=3D/,'=')

    build_purchase_object
    parse_items_and_add_to_purchase
    @purchase.raw_message = @email.raw_html

    return @purchase
  end

private

  def build_purchase_object
    @purchase = Purchase.new(
                              vendor:           'Caviar',
                              sender_email:     @email.from.to_s,
                              sub_vendor:       parse_sub_vendor,
                              order_unique_id:  parse_order_number,
                              total_price:      parse_order_total,
                              order_date:       @email.date ? @email.date : nil
                             )
  end

  def parse_sub_vendor
    return @body_html
            .xpath('//td')
            .map{ |t| t if matches_element_characteristic?(t['style'], 'color:#2d394f;font-size:18px;line-height:24px;font-weight:700;text-align:center;padding:32px 0 0') }
            .compact[0]
            .text
            .strip
  end

  def parse_order_number
    return @body_html
            .xpath('//a')
            .map{ |t| t if matches_element_characteristic?(t['style'], '-moz-border-radius: 4px;-webkit-border-radius: 4px;border-radius: 4px;border: 1px solid #ff7f2a;color: #ffffff;display: inline-block;padding: 13px 28px;text-decoration: none') }
            .compact[0]['href'] #Use the unique ID as the order #
            .gsub(/\A.*\//, '')
  end

  def parse_order_total
    return @body_html
            .xpath('//td')
            .map{ |t| t if matches_element_characteristic?(t['style'], 'color:#2d394f;font-size:18px;line-height:24px;font-weight:700') }
            .compact[0]
            .text
            .gsub(/\$/, '')
            .strip
  end

  def parse_items_and_add_to_purchase
    quantities = @body_html
                  .xpath('//td')
                  .map { |t| t if matches_element_characteristic?(t['style'], 'color:#5f6a7c;font-size:14px;line-height:18px;text-align:left;padding:0 4px 0 0') }
                  .compact
                  .map { |h| h.text.strip.to_f }

    names = @body_html
              .xpath('//td')
              .map { |t| t if matches_element_characteristic?(t['style'], 'color:#2d394f;font-size:14px;line-height:18px;padding:0 0 4px') }
              .compact
              .map { |h| h.text.strip }

    descs = @body_html
              .xpath('//td')
              .map { |t| t if matches_element_characteristic?(t['style'], 'color:#2d394f;font-size:12px;line-height:18px;padding:0 0 2px') }
              .compact
              .map { |h| h.text.gsub(/\s{2,}/, " ").strip.gsub(' +', '; ').gsub(/\A\+/, '') }

    prices = @body_html
              .xpath('//td')
              .map { |t| t if matches_element_characteristic?(t['style'], 'color:#2d394f;font-size:14px;line-height:18px;padding:0 0 0 20px') }
              .compact
              .map { |h| h.text.strip }

    quantities.count.times do |index|
      item_hash = { category: 'Prepared Meals' }

      item_hash[:quantity]        = quantities[index]
      item_hash[:name]            = names[index]
      item_hash[:description]     = descs[index]
      item_hash[:price_breakdown] = prices[index]
      item_hash[:total_price]     = item_hash[:price_breakdown].gsub(/\$/, '').to_f

      @purchase.itemizables << build_itemizable(item_hash)

    end
  end

end
