object @purchase

attributes :id,
           :vendor,
           :total_price

node (:purchase_date) { |p| p.created_at }