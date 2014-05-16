ActiveAdmin.register User do
  actions :all, except: [:edit]

  index do
    selectable_column
    id_column

    column :endpoint_email
    column :sign_in_count
    column :confirmed_at
    column :confirmation_sent_at
    column :created_at
    column :updated_at
    column :household_size

    actions
  end

  show do |ad|
    attributes_table do
      row :endpoint_email
      row :sign_in_count
      row :confirmed_at
      row :confirmation_sent_at
      row :created_at
      row :updated_at
      row :household_size
    end
    active_admin_comments
  end
  
end
