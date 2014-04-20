object @item

attributes :id,
           :purchase_id,
           :name, 
           :description,
           :price_breakdown,
           :category,
           :total_price,
           :quantity,
           :discounted

node (:purchase_date) { |i| i.created_at }

node :nutritional_data do |i|
  hash = {}
  Item.nutritionix_api_fields.each do |field|
    hash[field] = i.send(field)
  end
  hash
end