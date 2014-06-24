ActiveAdmin.register Item do
  actions :all, except: [:new, :edit, :delete]

  index do
    selectable_column
    id_column

    column :name
    column :purchase
    column :description
    column :price_breakdown
    column :category
    column :total_price
    column :quantity
    column :discounted
    column :created_at

    actions
  end

end
