class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :purchase, index: true
      t.string     :name
      t.string     :description
      t.string     :price_breakdown
      t.string     :category
      t.float      :total_price
      t.float      :quantity
      t.boolean    :discounted, default: false

      t.timestamps
    end
  end
end
