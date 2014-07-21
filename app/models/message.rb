class Message < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :oauth_application

  serialize   :to, Array

  after_create :pass_through_original_email

private

  def pass_through_original_email
    UserMailer.delay.message_received(self)
  end

end
