class EmailProcessor
  def self.process(email)
    @email = email
    source_email = @email.from
    target_email = filter_other_recipients(@email.to)

    # if target_email == 'set_your_mission'
    #   set_user_from_email(source_email)
      
    #   @user.reset_mission_statement(@email.subject)
    #   create_message('user_mission_setting_message', @user, app)
    # elsif target_email == 'set_my_mission'
    #   set_user_from_email(source_email)
    #   @user.reset_mission_statement(@email.subject)
    #   create_message('user_mission_setting_message', @user, app)
    if target_email =~ /^pushcart-app-/
      set_user_from_email(source_email)
      unless @user.nil?
        app = ClientApp.find_by_endpoint_email target_email.gsub(/^pushcart-app-/, '')
        create_message('user_to_application_message', @user, app)
      end
    else
      set_user_from_email(target_email)

      unless @user.nil?
        create_message('grocery_vendor_to_user_message', @user)

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
                  m.to                 = @email.to
                  m.from               = @email.from
                  m.subject            = @email.subject
                  m.kind               = kind
                  m.user               = user unless user.nil?
                  m.oauth_application  = app  unless app.nil?
                end
  end

  def self.set_user_from_email(email_address)

    if email_address =~ /@#{EMAIL_URI}/
      @user = User.find_by_endpoint_email email_address.gsub(/@#{EMAIL_URI}/, '')
    else
      @user = User.find_by_email email_address
    end

    if @user.nil?
      UserMailer.delay.cannot_find_account(@email, email_address)
      Rails.logger.info "Invalid e-mail address for user: #{email_address}"
    end
  end

end