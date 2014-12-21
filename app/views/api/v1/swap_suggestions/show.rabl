object @swap_suggestion

attributes :id,
           :message_sent_at,
           :swap_rated_at,
           :user_rating,
           :feedback,
           :created_at

child :swap do
  extends 'api/v1/swaps/show'
end

child :item do
  extends 'api/v1/items/show'
end