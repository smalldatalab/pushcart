ActiveAdmin.register Item do
  permit_params :swap_id
  actions :all, except: [:new, :destroy]

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

  form do |f|
    f.inputs "Make a swap" do
      f.input :swap
    end
    f.actions
  end

end
