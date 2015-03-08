class Purchase < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  belongs_to  :user
  has_many	  :itemizables, dependent: :destroy
  has_many    :items, through: :itemizables

  validates_presence_of :itemizables, :user

end
