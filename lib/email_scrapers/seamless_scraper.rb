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
                  total_price:  parse_order_total.gsub(/\$/, ''),
                  order_date:   @email.date ? @email.date : nil
                }.merge parse_metadata

    @purchase = Purchase.new(purchase)
  end

  def parse_metadata
    metadata = {}

    metadata_table = @body_html
                      .xpath('//table')
                      .map{ |t| t if matches_element_characteristic?(t['style'], 'border-top:4px solid #cccccc') }

    metadata_table = first_clean_match(metadata_table)

    table_children = clean_matches(metadata_table.children)

    if table_children.first.name == 'tbody'
      table_children.each do |tbody|
        clean_matches(tbody.children).each do |tr|
          tds = clean_matches(tr.children)

          metadata[:sub_vendor]       = parse_sub_vendor tds[0]

          final_div = (tds.count == 3 ? tds.last : tds[4])

          metadata[:order_unique_id]  = parse_order_number final_div
          metadata[:order_date]       = DateTime.parse(parse_order_date final_div)
        end
      end
    else
      table_children.each do |tr|
        tds = clean_matches(tr.children)

        metadata[:sub_vendor]       = parse_sub_vendor tds[0]

        final_div = (tds.count == 3 ? tds.last : tds[4])

        metadata[:order_unique_id]  = parse_order_number final_div
        metadata[:order_date]       = DateTime.parse(parse_order_date final_div)
      end
    end

    return metadata
  end

  def parse_sub_vendor(td)
    node = td
            .children
            .map{ |t| t if (matches_element_characteristic?(t['style'], 'font-family:Arial,Helvetica,sans-serif;font-size:18px;padding-top:.25em;padding-bottom:.25em;line-height:22px;color:#444444;text-align:left;font-weight:normal') || matches_element_characteristic?(t['style'], 'font-family:Arial,Helvetica,sans-serif;font-size:18px;padding-top:.25em;padding-bottom:.25em;line-height:22px;color:#000000;text-align:left;font-weight:normal')) }

    node = first_clean_match(node)

    return node
            .children
            .text
  end

  def parse_order_date(td)
    node = td
            .children
            .map{ |t| t if matches_element_characteristic?(t['style'], 'font-family:Arial,Helvetica,sans-serif;padding-top:0em;padding-right:0em;padding-bottom:.25em;font-size:12px;line-height:17px;text-align:left;font-weight:normal') }

    node = first_clean_match(node)

    return node
            .children
            .text
            .gsub(/Ordered:/, '')
            .strip
  end

  def parse_order_number(td)
    node = td
            .children
            .map{ |t| t if t['style'] && matches_element_characteristic?(t['style'], 'font-family:Arial,Helvetica,sans-serif;font-size:18px;padding-top:.25em;padding-bottom:.25em;line-height:22px;text-align:left;font-weight:normal') }

    node = first_clean_match(node)

    return node
            .children
            .text
            .gsub(/\p{Space}/, ' ')
            .gsub(/(\=C2\=A0|\s\s|Order #:)/, '')
            .strip
  end

  def parse_order_total
    return @body_html
            .xpath('//span')
            .map{ |t| t if matches_element_characteristic?(t['style'], 'font-family:Arial,Helvetica,sans-serif;font-size:12px;line-height:20px;margin:0em;padding:0em;color:#c90117;text-align:left;font-weight:bold') }
            .compact[0]
            .text
  end

  def parse_items_and_add_to_purchase
    item_tables = @body_html
                    .xpath('//table')
                    .map{ |t| t if matches_element_characteristic?(t['style'], 'background-color:#ffffff') }

    item_tables = clean_matches(item_tables)

    item_tables.each do |table|
      table_children = clean_matches(table.children)

      if table_children.first.name == 'tbody'
        table_children.each do |tbody|
          clean_matches(tbody.children).each do |tr|
            parse_item(tr)
          end
        end
      else
        table_children.each do |tr|
          parse_item(tr)
        end
      end
    end
  end

  def parse_item(tr)
    item_hash = { category: 'Prepared Meals' }

    # NOTE: Scrapes both items and optional add-ons as items

    tr_children = clean_matches(tr.children)

    if (tr_children.count == 12 || tr_children.count == 6) && tr_children.first.text.blank?
      # Special request to primary item

      desc = nil

      tr_children
        .map { |t| t.text if t.name = 'strong' }
        .map { |t| desc = t.gsub(/\=E2\=80\=A2/, '').gsub(/\A\p{Space}*/, '').strip unless t.blank? }

      if desc
        item = @purchase.itemizables.last.item
        item.update_attributes!(description: item.description + "\n#{desc}") unless Regexp.new(item.description) =~ desc
      end

    elsif tr_children.count == 12 || tr_children.count == 6
      # Primary item

      tds = tr_children.map { |t| t if t.name == 'td' }.compact

      item_hash[:description] = 'Base order item'

      item_hash[:quantity] = tds[0]
                              .children
                              .map{ |t| t if matches_element_characteristic?(t['style'], 'font-family: Arial, Helvetica, sans-serif; font-size: 18px; padding-top: .25em; padding-bottom: .25em; line-height: 22px; text-align: left; font-weight: normal;') }
                              .compact[0]
                              .children[0]
                              .text

      item_hash[:name] = tds[1]
                          .children[0]
                          .text
                          .strip

      item_hash[:price_breakdown] = tds[2]
                                      .children[0]
                                      .text
                                      .strip + ' (base price)'

      item_hash[:total_price] = tds[5]
                                  .children[0]
                                  .text
                                  .strip.gsub(/\$/, '')

      @purchase.itemizables << build_itemizable(item_hash)
    elsif tr_children.count == 10 || tr_children.count == 5
      # Supplementary items

      tds = tr_children.map { |t| t if t.name == 'td' }.compact

      item_hash[:description] = 'Add-on item (cost inclued in base item total cost)'

      item_hash[:name] = tds[1]
                          .children
                          .map{ |t| t if matches_element_characteristic?(t['style'], 'font-size:12px;margin:0em;padding:0em;font-family:Arial,Helvetica,sans-serif;line-height:18px;text-align:left;list-style:disc') }
                          .compact[0]
                          .text
                          .gsub(/(\=A0|\=C2|\=E2|\=80|\=A2|•)/, '')
                          .gsub(/\A\p{Space}*/, '')
                          .gsub(/\A\*/, '')
                          .strip

      price =  tds[2]
                .children[0]
                .text
                .gsub(/(\=A0|\=C2)/, '')
                .gsub(/\A\p{Space}*/, '')
                .strip

      item_hash[:price_breakdown] = (price.blank? ? 'free' : price) + ' (add-on price)'

      item_hash[:quantity] = 1

      item_hash[:total_price] = 0.0

      @purchase.itemizables << build_itemizable(item_hash)
    end
  end

end
