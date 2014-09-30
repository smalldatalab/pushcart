class Purchase < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  belongs_to  :user
  has_many    :items, dependent: :destroy
  validates_presence_of :items, :user

end
