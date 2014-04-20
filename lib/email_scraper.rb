class EmailScraper

  def initialize(email, user)
    @email = email
    @user  = user
  end

  def scrape
    scraper = determine_scraper

    if !scraper
      return false
    else
      @user.purchases << process_email_body(scraper)
      if @user.save
        return true
      else
        @user.purchases.each do |i|
          Rails.logger.info i.errors.full_messages
          i.items.each do |t|
            Rails.logger.info t
            Rails.logger.info t.errors.full_messages
          end
        end
        Rails.logger.info @user.errors.full_messages
        return false
      end
    end
  end

  def process_email_body(scraper)
    if scraper == :fd
      return FreshDirectScraper.new(@email).process_purchase
    elsif scraper == :instacart
      return InstacartScraper.new(@email).process_purchase
    end
  end

  def determine_scraper
    if @email.subject =~ /Your\sorder\sfor/ && @email.raw_text =~ /Fresh\sDirect/
      return :fd
    elsif @email.subject =~ Regexp.new('Your Order with Instacart')
      return :instacart
    else
      return false
    end
  end

end

# email = Mail.new do
#   from    'receipt@freshdirect.com'
#   to      'charming-sands-affectionate-tundra@lets.gopushcart.com'
#   subject 'Your order for Sunday, Jan 26 2014'
#   html_part do
#     body    File.read(Rails.root.to_s + '/lib/sample_emails/fresh_direct/receipt_one.eml')
#   end
# end

# email = Mail.new do
#   from    'orders@instacart.com'
#   to      'charming-sands-affectionate-tundra@lets.gopushcart.com'
#   subject 'Fwd: Your Order with Instacart'
#   html_part do
#     body    File.read(Rails.root.to_s + '/lib/sample_emails/instacart/instacart_receipt.eml')
#   end
# end

# t = EmailScraper.new(email, User.last!).scrape