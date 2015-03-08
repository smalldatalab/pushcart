class GrubhubScraper < ReceiptScraper

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
                              vendor:           'Grubhub',
                              sender_email:     @email.from.to_s,
                              sub_vendor:       parse_sub_vendor,
                              order_unique_id:  parse_order_number,
                              total_price:      parse_order_total,
                              order_date:       @email.date ? @email.date : nil
                             )
  end

  def parse_sub_vendor
    return @body_html
            .xpath('//h4')
            .text
            .strip
  end

  def parse_order_number
    return @body_html
            .xpath('//font')
            .map{ |t| t if matches_element_characteristic?(t['style'], 'text-align:left; color:#928a95; font-size:17px;') }
            .compact[0]
            .text
            .gsub(/Order #/, '')
            .strip
  end

  def parse_order_total
    element = @body_html
              .xpath('//td')
              .map{ |t| t if matches_element_characteristic?(t['style'], 'border-collapse: collapse; color: rgb(64, 51, 69); text-align: left;') }
              .compact[0]

    # Try 2014 style
    if element.nil?
      element = @body_html
                .xpath('//td')
                .map{ |t| t if matches_element_characteristic?(t['style'], 'color:#403345; text-align:left;') }
                .compact[0]
    end

    return element
            .children[0]
            .text
            .gsub(/\$/, '')
            .strip
  end

  def parse_items_and_add_to_purchase
    tbody_trs = @body_html
                  .xpath('//table')
                  .map { |t| t if matches_element_characteristic?(t['style'], 'background-color:#ffffff;') }
                  .compact[0]
                  .children

    if tbody_trs.first.name == 'tbody'
      item_trs = tbody_trs[0] #tbody level
                  .children[1] #tr level
                  .children[0] #td level
                  .children
                  .map { |t| t if matches_element_characteristic?(t['style'], 'font-size:15px; color:#403345;') }
                  .compact[0] # item table
                  .children[0] # item tbody
                  .children
    elsif tbody_trs.first.name == 'tr'
      item_trs = tbody_trs[1] #tr level
                  .children[0] #td level
                  .children
                  .map { |t| t if matches_element_characteristic?(t['style'], 'font-size:15px; color:#403345;') }
                  .compact[0] # item table
                  .children
    end

    item_trs.each do |tr|
      item_hash = { category: 'Prepared Meals' }
      tds = tr.children
      item_hash[:quantity]        = tds[0].text.strip.to_f
      item_hash[:name]            = tds[1].text.strip
      item_hash[:price_breakdown] = tds[2].text.gsub(' ', '')
      item_hash[:total_price]     = item_hash[:price_breakdown].gsub(/\$/, '').to_f

      @purchase.itemizables << build_itemizable(item_hash)
    end
  end

end
