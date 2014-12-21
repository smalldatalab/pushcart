class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :coach

  validates_presence_of :user, :coach
end
