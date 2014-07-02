class HouseholdMember < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :age, :gender

  def self.age_collection
    [
      '0 - 5', 
      '6 - 12', 
      '13 - 18', 
      '19 - 25', 
      '26 - 35', 
      '36 - 45', 
      '46 - 55', 
      '56 - 65', 
      '66 - 75', 
      '75 or older',
      'N/A'
    ]
  end

end
