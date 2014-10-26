class AlertMailer < BaseMailer

  def forward_to_team(email)
    @email = email
    mail(
        to: ['michael@aqua.io', 'baum.aaron@gmail.com'],
        reply_to: @email.from,
        subject: "[Pushcart contact from #{@email.from}] #{@email.subject}"
      )
  end

end
