object @purchase

attributes :id,
           :vendor,
           :total_price

node (:purchase_date) { |p| p.created_at }

if @show_items
  child :items do
    extends "api/#{@api_version}/items/show"
  end
end