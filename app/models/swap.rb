class Swap < ActiveRecord::Base
  belongs_to :swap_category

  has_many :items

  validates_presence_of :name, :swap_category_id
  validates_uniqueness_of :name
end
