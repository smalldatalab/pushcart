class AddSubVendorToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :sub_vendor, :string
    add_column :purchases, :order_date, :datetime
  end
end
