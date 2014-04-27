class EmailProcessor
  def self.process(email)
    user = User.find_by_endpoint_email filter_other_recipients(email.to).gsub(/@#{EMAIL_URI}/, '')
    if user.nil?
      UserMailer.cannot_find_account(email).deliver
    # elsif EmailScraper.new(email, user).scrape
    #   UserMailer.email_processed(user, email).deliver
    else
      inbound = InboundEmail.create do |ie|
                  ie.user     = user
                  ie.raw_html = email.raw_html
                  ie.raw_text = email.raw_text
                  ie.to       = email.to
                  ie.from     = email.from
                  ie.subject  = email.subject
                end

      EmailScraper.delay.new(inbound.id)
    end
  end

private

  def self.filter_other_recipients(recipients)
    recipients.find { |address| address =~ /@#{EMAIL_URI}$/ }
  end

end