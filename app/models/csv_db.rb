require 'csv'
class CsvDb
  class << self

    def convert_save(csv_data)
      p csv_data
      csv_file = csv_data.read
      CSV.parse(csv_file) do |row|
        if row[0] == "Store :"
          # First row of the receipt
          p "New purchase. Customer: #{row[11]}"
          @user = User.find_or_create_by(email: row[11])
          @purchase = Purchase.new({
                                    vendor:           'Durham Coop Market',
                                    sender_email:     'CSV Import',
                                    order_unique_id:  row[13],
                                    order_date:       row[3]
                                  })
        elsif row[0] == "total"
          # Last row of the receipt, before next receipt starts
          @purchase.total_price = row[4]
          p "User: #{@user.email}, Order: #{@purchase.order_unique_id}, Total: #{@purchase.total_price}"
          @user.purchases << @purchase
          p @user.purchases
          @user.save
        else
          @purchase.itemizables << build_itemizable(row)
        end

      end
    end

    def build_itemizable(row)
      item = Item.find_or_create_by({name: row[1], description: "ID: #{row[0]}"})

      itemizable = Itemizable.new({quantity: row[2], total_price: row[4], price_breakdown: "#{row[2]} x $#{row[3]}"})
      itemizable.item = item

      return itemizable
    end
  end
end
