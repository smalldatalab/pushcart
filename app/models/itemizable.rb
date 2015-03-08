class Itemizable < ActiveRecord::Base

  belongs_to :purchase
  belongs_to :item

  has_one :user, through: :purchase

  validates_presence_of :item, :purchase

  validates :color_code,
              inclusion: {
                           in: proc { Item.color_code_options },
                           message: "%{value} is not a valid stoplight color"
                         },
              allow_blank: true

  def self.color_code_options
    %W(red yellow green)
  end

  def servings_total
    quantity.to_f * item.servings_per.to_f
  end

end
