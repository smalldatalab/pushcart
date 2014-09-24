class CreateSwap < ActiveRecord::Migration
  def change
    create_table :swap_categories do |t|
      t.string      :name

      t.timestamps
    end

    create_table :swaps do |t|
      t.belongs_to  :swap_category, index: true
      t.string      :name

      t.timestamps
    end

    add_column :items, :swap_id, :integer, index: true
  end
end
