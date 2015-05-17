class ChangeMessageFieldsToText < ActiveRecord::Migration
  def up
   change_column :messages, :to, :text
   change_column :messages, :from, :text
   change_column :messages, :subject, :text
   change_column :messages, :kind, :text
   change_column :messages, :source, :text
  end

  def down
   change_column :messages, :to, :string
   change_column :messages, :from, :string
   change_column :messages, :subject, :string
   change_column :messages, :kind, :string
   change_column :messages, :source, :string
  end
end
