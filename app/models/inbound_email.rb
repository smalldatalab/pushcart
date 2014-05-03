class InboundEmail < ActiveRecord::Base
  belongs_to  :user
  serialize   :to, Array

  scope :older_than_a_month, -> { where("created_at < ?", 4.weeks.ago) }

end
