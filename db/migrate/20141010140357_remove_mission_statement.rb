class RemoveMissionStatement < ActiveRecord::Migration
  def change
    remove_column :users, :mission_statement, :text
    remove_column :missions, :description, :text
  end
end
