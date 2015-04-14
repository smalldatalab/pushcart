class Itemizable < ActiveRecord::Base

  belongs_to :purchase
  belongs_to :item
  belongs_to :coach
  belongs_to :swap

  has_one :user, through: :purchase

  after_save :send_swap_message, if: Proc.new { |i| i.swap_id && i.swap_id_changed? }

  validates_presence_of :item, :purchase

  validates :color_code,
              inclusion: {
                           in: proc { Itemizable.color_code_options },
                           message: "%{value} is not a valid stoplight color"
                         },
              allow_blank: true

  def self.color_code_options
    %W(red yellow green)
  end

  def servings_total
    quantity.to_f * item.servings_per.to_f
  end

private

  def send_swap_message
    UserMailer.delay.replacement_suggestion(self.id)
  end

end
