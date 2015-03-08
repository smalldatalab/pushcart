class EmailProcessor
  def self.process(email)
    @email = email
    source_email = @email.from[:email]
    target_email = filter_other_recipients(@email.to[:email])

    if target_email =~ /^info@/
      AlertMailer.forward_to_team(@email).deliver
    else
      set_user_from_email(target_email)

      unless @user.nil?
        create_message('vendor_to_user_message', @user)

        EmailScraper.delay.new(@message.id)
      end
    end
  end

private

  def self.filter_other_recipients(recipients)
    recipients.find { |address| address =~ /@#{EMAIL_URI}$/ }
  end

  def self.create_message(kind, user=nil, app=nil)
    @message =  Message.create do |m|
                  m.raw_html           = @email.raw_html
                  m.raw_text           = @email.raw_text
                  m.to                 = @email.to[:email]
                  m.from               = @email.from[:email]
                  m.subject            = @email.subject
                  m.kind               = kind
                  m.source             = 'inbound_email_processor'
                  m.user               = user unless user.nil?
                  m.source             = 'inbound email'
                end
  end

  def self.set_user_from_email(email_address)

    if email_address =~ /@#{EMAIL_URI}/
      @user = User.find_by_endpoint_email email_address.gsub(/@#{EMAIL_URI}/, '')
    else
      @user = User.find_by_email email_address
    end

    if @user.nil?
      p @email
      UserMailer.delay.cannot_find_account(@email, email_address)
      Rails.logger.info "Invalid e-mail address for user: #{email_address}"
    end
  end

end