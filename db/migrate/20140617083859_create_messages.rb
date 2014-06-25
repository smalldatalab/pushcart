class CreateMessages < ActiveRecord::Migration
  def change
    rename_table :messages, :messages

    change_table :messages do |t|
      t.string      :kind
      t.belongs_to  :oauth_application, index: true
    end

    add_column :oauth_applications, :endpoint_email, :string

    create_table :missions do |t|
      t.string  :name
      t.text    :description

      t.timestamps
    end

    add_column :users, :mission_id,         :integer, index: true
    add_column :users, :mission_statement,  :text
  end
end
