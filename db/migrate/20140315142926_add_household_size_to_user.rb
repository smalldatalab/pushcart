class AddHouseholdSizeToUser < ActiveRecord::Migration
  def change
    add_column :users, :household_size, :integer
  end
end
