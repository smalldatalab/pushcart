object @purchase

attributes :id,
           :vendor,
           :sub_vendor,
           :total_price

node (:purchase_date) { |purchase| purchase.order_date || purchase.created_at }

if @show_items
  child :itemizables => :items do
    extends "api/#{@api_version}/itemizables/show"
  end
end