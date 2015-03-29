class UpdateSwaps < ActiveRecord::Migration
  def change
    add_column :itemizables, :swap_id,  :integer, index: true
    add_column :itemizables, :coach_id, :integer, index: true

    drop_table :swap_suggestions
  end
end
