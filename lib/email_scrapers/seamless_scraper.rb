class SeamlessScraper < ReceiptScraper

  def process_purchase
    @body_html = Nokogiri::HTML::Document.parse clean_body_html.gsub(/\=3D/,'=')

    build_purchase_object
    parse_items_and_add_to_purchase
    @purchase.raw_message = @email.raw_html

    return @purchase
  end

private

  def build_purchase_object
    purchase = {
                  vendor:       'Seamless',
                  sender_email: @email.from.to_s,
                  total_price:  parse_order_total.gsub(/\$/, '')
                }.merge parse_metadata

    @purchase = Purchase.new(purchase)
  end

  def parse_metadata
    metadata = {}

    metadata_table = @body_html
                      .xpath('//table')
                      .map{ |t| t if matches_element_characteristic?(t['style'], 'border-top:4px solid #cccccc') }
                      .compact
                      .first

    metadata_table.children.each do |tbody|
      tbody.children.each do |tr|
        tds = tr.children

        metadata[:sub_vendor]       = parse_sub_vendor tds[0]
        metadata[:order_unique_id]  = parse_order_number tds[4]
        metadata[:order_date]       = DateTime.parse(parse_order_date tds[4])

      end
    end

    return metadata
  end

  def parse_sub_vendor(td)
    return td
      .children
      .map{ |t| t if matches_element_characteristic?(t['style'], 'font-family:Arial,Helvetica,sans-serif;font-size:18px;padding-top:.25em;padding-bottom:.25em;line-height:22px;color:#444444;text-align:left;font-weight:normal') }
      .compact
      .first
      .children
      .text
  end

  def parse_order_date(td)
    return td
      .children
      .map{ |t| t if matches_element_characteristic?(t['style'], 'font-family:Arial,Helvetica,sans-serif;padding-top:0em;padding-right:0em;padding-bottom:.25em;font-size:12px;line-height:17px;color:#000000;text-align:left;font-weight:normal') }
      .compact
      .first
      .children
      .text.gsub(/Ordered:/, '').strip
  end

  def parse_order_number(td)
    return td
      .children
      .map{ |t| t if matches_element_characteristic?(t['style'], 'font-family:Arial,Helvetica,sans-serif;font-size:18px;padding-top:.25em;padding-bottom:.25em;line-height:22px;color:#000000;text-align:left;font-weight:normal') }
      .compact
      .first
      .children
      .text.gsub(/(\=C2\=A0|Order #:)/, '').strip
  end

  def parse_order_total
    spans = @body_html.xpath('//span').map{ |t| t if matches_element_characteristic?(t['style'], 'font-family:Arial,Helvetica,sans-serif;font-size:12px;line-height:20px;margin:0em;padding:0em;color:#c90117;text-align:left;font-weight:bold') }.compact
    return spans.first.text
  end

  def parse_items_and_add_to_purchase
    item_tables = @body_html
                    .xpath('//table')
                    .map{ |t| t if matches_element_characteristic?(t['style'], 'background-color:#ffffff') }
                    .compact


    item_tables.each do |table|
      table.children.each do |tbody|
        tbody.children.each do |tr|
          item_hash = { category: 'Prepared Meals' }

          # NOTE: Scrapes both items and optional add-ons as items

          if tr.children.count == 12 && tr.children.first.children.count == 1 
            # Special request to primary item

            tr
              .children
              .map { |t| t.text if t.name = 'strong' }
              .map { |t| @purchase.items.last.description << t.gsub(/\=E2\=80\=A2/, '').gsub(/\A\p{Space}*/, '').strip unless t.blank? }

          elsif tr.children.count == 12
            # Primary item

            tds = tr.children.map { |t| t if t.name == 'td' }.compact

            item_hash[:description] = 'Base order item'

            item_hash[:quantity] = tds[0]
                                    .children
                                    .map{ |t| t if matches_element_characteristic?(t['style'], 'font-family: Arial, Helvetica, sans-serif; font-size: 18px; padding-top: .25em; padding-bottom: .25em; line-height: 22px; color: #000000; text-align: left; font-weight: normal;') }
                                    .compact
                                    .first
                                    .children
                                    .first
                                    .text

            item_hash[:name] = tds[1]
                                .children
                                .first
                                .text
                                .strip

            item_hash[:price_breakdown] = tds[2]
                                            .children
                                            .first
                                            .text
                                            .strip + ' (base price)'

            item_hash[:total_price] = tds[5]
                                        .children
                                        .first
                                        .text
                                        .strip.gsub(/\$/, '')

            @purchase.items << Item.new(item_hash)
          elsif tr.children.count == 10
            # Supplementary items

            tds = tr.children.map { |t| t if t.name == 'td' }.compact

            item_hash[:description] = 'Add-on item (cost inclued in base item total cost)'

            item_hash[:name] = tds[1]
                                .children
                                .map{ |t| t if matches_element_characteristic?(t['style'], 'font-size:12px;margin:0em;padding:0em;font-family:Arial,Helvetica,sans-serif;line-height:18px;color:#000000;text-align:left;list-style:disc') }
                                .compact
                                .first
                                .text
                                .gsub(/(\=A0|\=C2|\=E2|\=80|\=A2)/, '')
                                .gsub(/\A\p{Space}*/, '')
                                .gsub(/\A\*/, '')
                                .strip

            price =  tds[2]
                      .children
                      .first
                      .text
                      .gsub(/(\=A0|\=C2)/, '')
                      .gsub(/\A\p{Space}*/, '')
                      .strip                      

            item_hash[:price_breakdown] = (price.blank? ? 'free' : price) + ' (add-on price)'

            item_hash[:quantity] = 1

            item_hash[:total_price] = 0.0

            @purchase.items << Item.new(item_hash)
          end
        end
      end
    end
  end

end
