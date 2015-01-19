class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :coach

  validates_presence_of :user, :coach

  after_create :send_notice_to_coach

private

  def send_notice_to_coach
    CoachMailer.delay.new_team_member(self.id)
  end

end
