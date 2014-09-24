class SwapCategory < ActiveRecord::Base
  has_many :swaps
  has_many :items

  validates_presence_of :name
  validates_uniqueness_of :name
end