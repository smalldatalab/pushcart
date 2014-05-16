ActiveAdmin.register Purchase do
  actions :all, except: [:new, :edit, :delete]

  index do
    selectable_column
    id_column

    column :vendor
    column :total_price
    column :created_at
    column :ntx_api_rejected_item_count
    column :category_rejected_item_count

    actions
  end

  show do |ad|
    attributes_table do
      row :id
      row :vendor
      row :total_price
      row :created_at
      row :ntx_api_rejected_item_count
      row :category_rejected_item_count 
    end

    panel "Items" do
      table_for ad.items do 
        column("name")      { |item| link_to item.name, admin_item_path(item) }
        column :category
        column :quantity
        column :total_price
      end
    end

    active_admin_comments
  end
  
end
