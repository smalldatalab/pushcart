module WeeklyEmailDigester
  extend self

  def build(user)
    build_digest(user)
  end

private

  def build_digest(user)
    user.inbound_emails.map.with_index do |inbound_email, i|
      "Mail #: #{i+1}\n" +
      "Subject: #{inbound_email.subject}\n" +
      "Time Received: #{inbound_email.created_at}\n"
    end
  end

end
