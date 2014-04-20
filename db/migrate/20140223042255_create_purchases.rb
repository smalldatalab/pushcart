class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to  :user, index: true
      t.string      :vendor
      t.string      :sender_email
      t.string      :order_unique_id
      t.float       :total_price
      t.text        :raw_message

      t.timestamps
    end
  end
end
