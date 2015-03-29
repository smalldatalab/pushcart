object @itemizable

attributes :id,
           :purchase_id,
           :price_breakdown,
           :total_price,
           :quantity,
           :discounted,
           :color_code

node(:name)               { |i| i.item.name }
node(:description)        { |i| i.item.description }
node(:category)           { |i| i.item.category }
node(:user_id)            { |i| i.user.id }
node(:purchase_date)      { |i| i.created_at }
node(:filtered_category)  { |i| i.item.filtered_category }

node :nutritional_data do |i|
  hash = {}
  Item.nutritionix_api_fields.each do |field|
    hash[field] = i.item.send(field)
  end
  hash
end

child :swap do
  extends 'api/v1/swaps/show'
end