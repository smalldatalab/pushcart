module WeeklyEmailDigester
  extend self

  def build(user)
    build_digest(user)
  end

private

  def build_digest(user)
    user.messages.map.with_index do |inbound_email, i|
      "Mail #: #{i+1}\n" +
      "Subject: #{inbound_email.subject}\n" +
      "Sender: #{SITE_NAME}" +
      "Time Received: #{inbound_email.created_at}\n"
    end
  end

end
