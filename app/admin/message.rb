ActiveAdmin.register Message do
  actions :all, except: [:new, :edit, :delete]

  index do
    selectable_column
    id_column

    column :user
    column :from
    column :subject
    column :successfully_processed
    column :scraped
    column :created_at

    actions
  end

  show do |ad|
    attributes_table do
      row :user
      row :from
      row :subject
      row :successfully_processed
      row :scraped
      row :created_at
    end
    active_admin_comments
  end
  
end
