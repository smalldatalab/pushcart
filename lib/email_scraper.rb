class EmailScraper

  def initialize(email_id)
    @email = InboundEmail.find(email_id)
    @user  = @email.user
    evaluate_and_process
  end

  def evaluate_and_process
    @email.scraped = true if scrape

    @email.successfully_processed = true

    @email.save
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
    if !!(@email.subject =~ /Your\sorder\sfor/) && !!(@email.raw_text =~ /Fresh\sDirect/)
      return :fd
    elsif !!(@email.subject =~ Regexp.new('Your Order with Instacart'))
      return :instacart
    else
      return false
    end
  end

end

# email = FactoryGirl.create(:inbound_email, :fresh_direct_receipt_one, user: User.last!, to: ["#{User.last!.endpoint_email}@#{EMAIL_URI}"])

# t = EmailScraper.new(email, User.last!).scrape