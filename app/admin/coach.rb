ActiveAdmin.register Coach do
  permit_params :email, :password, :password_confirmation, :name

  actions :all

  index do
    selectable_column
    id_column

    column :email
    column :name
    column :last_sign_in_at
    column :created_at
    column :updated_at

    # actions
  end

  show do |ad|
    attributes_table do
      row :email
      row :name
      row :last_sign_in_at
      row :created_at
      row :updated_at
    end

    panel 'Members' do
      table_for ad.members do
        column :id
        column :email
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs "Coach Details" do
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
