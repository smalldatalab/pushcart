class EmailScraper

  def initialize(email_id)
    @email = Message.find(email_id)
    @user  = @email.user
    evaluate_and_process
  end

  def evaluate_and_process
    @email.scraped = true if scrape

    @email.successfully_processed = true

    @email.save

    UserMailer.delay.onboarding_complete(@user.id) if @email.scraped && @user.purchases.count == 1
  end

  def scrape
    scraper = determine_scraper(@email)

    if !scraper
      return false
    elsif scraper == :gmail_autoforwarder_confirm
      @email.kind = 'autoforwarder_confirmation'

      return GmailAutoforwarder.new(@email).process
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
    if scraper == :fresh_direct
      return FreshDirectScraper.new(@email).process_purchase
    elsif scraper == :instacart
      return InstacartScraper.new(@email).process_purchase
    elsif scraper == :peapod
      return PeapodScraper.new(@email).process_purchase
    elsif scraper == :seamless
      return SeamlessScraper.new(@email).process_purchase
    elsif scraper == :grubhub
      return GrubhubScraper.new(@email).process_purchase
    elsif scraper == :caviar
      return CaviarScraper.new(@email).process_purchase
    end
  end

  def determine_scraper(email)
    if matches_to(email.subject, 'Your order for') && matches_to(email.raw_text, /Fresh\s*Direct/i) && !matches_to(email.subject, 'on its way')
      return :fresh_direct
    elsif matches_to(email.subject, 'Your Order with Instacart')
      return :instacart
    elsif matches_to(email.subject, 'Peapod') && matches_to(email.subject, 'Order Confirmation')
      return :peapod
    elsif matches_to(email.subject, /\AConfirmed!\s/) && matches_to(email.raw_html, /seamless/i)
      return :seamless
    elsif matches_to(email.subject, /is\sin\sthe\sWorks$/) && matches_to(email.raw_html, /grubhub/i)
      return :grubhub
    elsif matches_to(email.subject, 'Your Caviar Order')
      return :caviar
    elsif matches_to(email.subject, 'Gmail Forwarding Confirmation') && email.from == 'forwarding-noreply@google.com'
      return :gmail_autoforwarder_confirm
    else
      return false
    end
  end

private

  def matches_to(input, candidate)
    if input.is_a? Regexp
      !!(input =~ candidate)
    else
      !!(input =~ Regexp.new(candidate))
    end
  end

end

# email = FactoryGirl.create(:email, :fresh_direct_receipt_one, user: User.last!, to: ["#{User.last!.endpoint_email}@#{EMAIL_URI}"])

# t = EmailScraper.new(email).scrape