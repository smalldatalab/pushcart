ActiveAdmin.register Itemizable do
  # permit_params :swap_id
  actions :all, except: [:new, :destroy]

  index do
    selectable_column
    id_column

    column :item
    column :purchase
    column :user
    column :created_at
    column :updated_at

    actions
  end

  form do |f|
    # f.inputs "Make a swap" do
    #   f.input :swap
    # end
    f.actions
  end

  csv do
    column :id
    column :item_id
    column :purchase_id
    column :quantity
    column :total_price
    column :price_breakdown
    column :discounted
    column :color_code
    column :created_at
    column :updated_at
  end

end
