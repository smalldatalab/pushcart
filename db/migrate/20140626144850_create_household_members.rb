class CreateHouseholdMembers < ActiveRecord::Migration
  def change
    create_table :household_members do |t|
      t.belongs_to  :user
      t.string      :age
      t.string      :gender

      t.timestamps
    end

    remove_column :users, :household_size, :integer
  end
end
