class Message < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  scope :with_coach,
        -> (coach_id) { where(coach_id: coach_id) }

  belongs_to  :user
  belongs_to  :coach

  serialize   :to, Array

  after_create :pass_through_original_email

private

  def pass_through_original_email
    UserMailer.delay(priority: 100).message_received(self.id)
  end

end
