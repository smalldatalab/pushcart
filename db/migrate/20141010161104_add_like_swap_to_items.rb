class AddLikeSwapToItems < ActiveRecord::Migration
  def change
    add_column :items, :swap_feedback, :string
  end
end
