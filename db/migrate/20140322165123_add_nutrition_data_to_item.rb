class AddNutritionDataToItem < ActiveRecord::Migration
  def change
    add_column :items,      :ntx_api_nutrition_data,        :json
    add_column :items,      :ntx_api_metadata,              :json
    add_column :purchases,  :ntx_api_rejected_item_count,   :integer
    add_column :purchases,  :category_rejected_item_count,  :integer
  end
end
