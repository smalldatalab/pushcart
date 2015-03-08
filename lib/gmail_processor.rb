require 'google/api_client'

class GmailProcessor

  def self.process(user_id)
    new(user_id).process_all_supported_emails
  end

  def initialize(user_id)
    @user               = User.find(user_id)
    @scrapable_services = YAML.load_file(Rails.root.to_s + '/lib/email_scrapers/scrapable_services.yml')
    @scrape_from        = @user.inbox_last_scraped ? @user.inbox_last_scraped - 1.day : nil
    @gmail_api          = GMAIL_CLIENT.discovered_api('gmail', 'v1')

    initialize_client
    refresh_authorization
  end

  def process_all_supported_emails
    @scrapable_services.each do |service|
      save_emails_as_messages(get_email_list_for_service(service), service)
    end

    @user.inbox_last_scraped = Time.now
    @user.save
  end

  def save_emails_as_messages(email_list, service)
    if email_list['messages']
      email_list['messages'].each_with_index do |email, index|
        full_email = JSON.parse @client.execute(
                                                  api_method: GMAIL_API.users.messages.get,
                                                  parameters: {
                                                                'id'     => email['id'],
                                                                'userId' => 'me',
                                                                'format' => 'full'
                                                              }
                                                ).body

        message = create_message(full_email)

        EmailScraper.delay.new(message.id)

        p "#{index} | #{message.from} | #{message.subject} | #{message.date}"
      end

      if email_list['nextPageToken']
        save_emails_as_messages(get_email_list_for_service(service, email_list['nextPageToken']), service)
      end
    end
  end

  def get_email_list_for_service(service, page_token=nil)
    date_string = @date ? " after:#{date.strftime("%Y/%m/%d")}" : ''

    p "Searching for #{service} e-mails..."

    result = @client.execute(
                              api_method: @gmail_api.users.messages.list,
                              parameters: {
                                            'userId' => 'me',
                                            'includeSpamTrash' => true,
                                            'q' => "from:(#{service[1]['sender_domain']})#{date_string}",
                                            'pageToken' => page_token
                                          }
                            )

    return JSON.parse(result.body)
  end

private

  def create_message(email_data)
    to = subject = from = html = text = date = nil

    email_data['payload']['headers'].each do |header|
      case header['name']
      when 'To'
        to      = header['value']
      when 'Subject'
        subject = header['value']
      when 'From'
        from    = header['value']
      when 'Date'
        date    = header['value']
      end
    end

    if email_data['payload']['parts']
      email_data['payload']['parts'].each do |part|
        case part['mimeType']
        when 'text/plain'
          text = part['body']['data']
        when 'text/html'
          html = part['body']['data']
        end
      end
    else
      html = email_data['payload']['body']['data']
    end

    return Message.create do |m|
             m.raw_html           = Base64.urlsafe_decode64(html) if html
             m.raw_text           = Base64.urlsafe_decode64(text) if text
             m.to                 = [to]
             m.from               = from
             m.subject            = subject
             m.inbox_metadata     = email_data.except 'payload'
             m.kind               = 'vendor_to_user_message'
             m.date               = date
             m.user               = @user
             m.source             = 'gmail API'
           end
  end

  def initialize_client
    @client = GMAIL_CLIENT.dup
  end

  def refresh_authorization
    @client.authorization.update_token!(
                                        access_token: @user.inbox_api_token['token'],
                                        refresh_token: @user.inbox_api_token['refresh_token']
                                       )

    if @client.authorization.refresh_token != @user.inbox_api_token['refresh_token']
      @user.inbox_api_token['refresh_token'] = auth.refresh_token
      @user.save
      p 'Token updated!'
    end
  end

end