object @item

attributes :id,
           :purchase_id,
           :name, 
           :description,
           :price_breakdown,
           :category,
           :total_price,
           :quantity,
           :discounted,
           :color_code,

node(:user_id) { |i| i.user.id }
node(:purchase_date) { |i| i.created_at }
node(:filtered_category) { |i| i.filtered_category }

node :nutritional_data do |i|
  hash = {}
  Item.nutritionix_api_fields.each do |field|
    hash[field] = i.send(field)
  end
  hash
end

child :swaps do
  extends 'api/v1/swaps/index'
end