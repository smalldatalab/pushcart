class GmailAutoforwarder

  def initialize(email)
    @email_body = email.raw_text
  end

  def process
    link = URI(get_link)
    resp = Net::HTTP.get_response(link)

    return resp && resp.code == '200'
  end

  def get_link
    URI.extract(@email_body, ['http', 'https'])[0]
  end

end
