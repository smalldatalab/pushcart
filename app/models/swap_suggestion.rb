class SwapSuggestion < ActiveRecord::Base
  belongs_to :swap
  belongs_to :item
  belongs_to :coach
  belongs_to :user
  belongs_to :message

  validates_presence_of :swap_id, :coach_id, :user_id, :item_id
  validates_uniqueness_of :item_id, scope: [:coach_id, :user_id, :swap_id]

  after_save :send_swap_message

  # validates :feedback, inclusion: {
  #                                   in: ['like', 'dislike'],
  #                                   message: "{%value} is not valid."
  #                                 },
  #                      allow_blank: true

private

  def send_swap_message
    UserMailer.replacement_suggestion(self).deliver
  end

end
