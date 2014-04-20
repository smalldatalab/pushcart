class EmailProcessor
  def self.process(email)
    user = User.find_by_endpoint_email filter_other_recipients(email.to).gsub(/@#{EMAIL_URI}/, '')
    if user.nil?
      UserMailer.cannot_find_account(email).deliver
    elsif EmailScraper.new(email, user).scrape
      UserMailer.email_processed(user, email).deliver
    else
      UserMailer.unprocessable_email(user, email).deliver
    end
  end

private

  def self.filter_other_recipients(recipients)
    recipients.find { |address| address =~ /@#{EMAIL_URI}$/ }
  end

end