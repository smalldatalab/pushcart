require 'spec_helper'

describe SeamlessScraper do

  test_receipts = [
                    {
                      name: :seamless_receipt_one,
                      order_date: '2015-01-22 22:45:00',
                      total_price: 49.98,
                      sub_vendor: 'Il Porto',
                      order_unique_id: '1119881214 C',
                      items: [
                              {"name"=>"Grandma Pie", "description"=>"Base order item", "price_breakdown"=>"$22.00 (base price)", "category"=>"Prepared Meals", "total_price"=>24.0, "quantity"=>1.0},
                              {"name"=>"Coke - Bottle", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"$2.00 (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Penne il Porto", "description"=>"Base order item", "price_breakdown"=>"$16.00 (base price)", "category"=>"Prepared Meals", "total_price"=>18.0, "quantity"=>1.0},
                              {"name"=>"Diet Coke - Bottle", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"$2.00 (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :seamless_receipt_two,
                      order_date: '2014-10-25 18:41:00',
                      total_price: 33.39,
                      sub_vendor: 'Chaska Fine Indian Cuisine',
                      order_unique_id: '805001092 C',
                      items: [
                              {"name"=>"Chicken Makhani", "description"=>"Base order item", "price_breakdown"=>"$12.95 (base price)", "category"=>"Prepared Meals", "total_price"=>15.45, "quantity"=>1.0},
                              {"name"=>"Naan", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"$2.50 (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Chicken Tikka Masala", "description"=>"Base order item", "price_breakdown"=>"$12.95 (base price)", "category"=>"Prepared Meals", "total_price"=>12.95, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :seamless_receipt_three,
                      order_date: '2014-12-19 22:49:00',
                      total_price: 45.37,
                      sub_vendor: 'Shinju III',
                      order_unique_id: '1008503024 C',
                      items: [
                              {"name"=>"Eel Don", "description"=>"Base order item", "price_breakdown"=>"$14.00 (base price)", "category"=>"Prepared Meals", "total_price"=>14.0, "quantity"=>1.0},
                              {"name"=>"Soup", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Eel Don", "description"=>"Base order item", "price_breakdown"=>"$14.00 (base price)", "category"=>"Prepared Meals", "total_price"=>14.0, "quantity"=>1.0},
                              {"name"=>"Soup", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Oyako Don", "description"=>"Base order item", "price_breakdown"=>"$10.00 (base price)", "category"=>"Prepared Meals", "total_price"=>10.0, "quantity"=>1.0},
                              {"name"=>"Soup", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :seamless_receipt_four,
                      order_date: '2014-12-07 17:56:00',
                      total_price: 44.37,
                      sub_vendor: 'Fusion Sushi (brought to you by Chef 28)',
                      order_unique_id: '959247886 C',
                      items: [
                              {"name"=>"Manhattan Roll", "description"=>"Base order item", "price_breakdown"=>"$12.00 (base price)", "category"=>"Prepared Meals", "total_price"=>12.0, "quantity"=>1.0},
                              {"name"=>"Spicy Tuna Roll", "description"=>"Base order item", "price_breakdown"=>"$6.50 (base price)", "category"=>"Prepared Meals", "total_price"=>6.5, "quantity"=>1.0},
                              {"name"=>"Maki Roll (Seaweed Outside, Rice Inside)", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Spicy King Crab Avocado Roll", "description"=>"Base order item", "price_breakdown"=>"$8.50 (base price)", "category"=>"Prepared Meals", "total_price"=>8.5, "quantity"=>1.0},
                              {"name"=>"Maki Roll (Seaweed Outside, Rice Inside)", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Hamachi Kama", "description"=>"Base order item", "price_breakdown"=>"$11.00 (base price)", "category"=>"Prepared Meals", "total_price"=>11.0, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :seamless_receipt_five,
                      order_date: '2015-01-19 13:00:00',
                      total_price: 17.46,
                      sub_vendor: 'Saigon Market',
                      order_unique_id: '1105675822 C',
                      items: [
                              {"name"=>"28. Pho Bo Soup", "description"=>"Base order item", "price_breakdown"=>"  (base price)", "category"=>"Prepared Meals", "total_price"=>9.25, "quantity"=>1.0},
                              {"name"=>"Large", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"$9.25 (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"28. Pho Bo Soup", "description"=>"Base order item", "price_breakdown"=>"  (base price)", "category"=>"Prepared Meals", "total_price"=>4.95, "quantity"=>1.0},
                              {"name"=>"Small", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"$4.95 (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :seamless_receipt_six,
                      order_date: '2015-02-02 14:31:00',
                      total_price: 20.78,
                      sub_vendor: 'Mamagyro (Broadway)',
                      order_unique_id: '1157113742 C',
                      items: [
                              {"name"=>"2 Mama's Gyros", "description"=>"Base order item\nSpecial Instructions: Extra Spicy Tzatziki Sauce", "price_breakdown"=>"$11.25 (base price)", "category"=>"Prepared Meals", "total_price"=>11.25, "quantity"=>1.0},
                              {"name"=>"Beef and Lamb (First Gyro)", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Beef and Lamb (Second Gyro)", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Whole Wheat Pita (First Gyro)", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Whole Wheat Pita (Second Gyro)", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Spicy Tzatziki Sauce (First Gyro)", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Spicy Tzatziki Sauce (Second Gyro)", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Spinach Quinoa", "description"=>"Base order item\nSpecial Instructions: No Dill Please", "price_breakdown"=>"$6.00 (base price)", "category"=>"Prepared Meals", "total_price"=>6.0, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :seamless_receipt_seven,
                      order_date: '2014-10-18 19:40:00',
                      total_price: 45.67,
                      sub_vendor: 'Amber (West Village)',
                      order_unique_id: '779998046 C',
                      items: [
                              {"name"=>"Basil Fried Rice Entr=C3=A9e", "description"=>"Base order item", "price_breakdown"=>"$13.00 (base price)", "category"=>"Prepared Meals", "total_price"=>13.0, "quantity"=>1.0},
                              {"name"=>"Shrimp", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Tuna or Salmon Avocado Roll", "description"=>"Base order item", "price_breakdown"=>"$6.00 (base price)", "category"=>"Prepared Meals", "total_price"=>12.0, "quantity"=>2.0},
                              {"name"=>"Salmon", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Maki Roll (Seaweed on the Outside)", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Asparagus Avocado Cucumber Roll", "description"=>"Base order item", "price_breakdown"=>"$5.00 (base price)", "category"=>"Prepared Meals", "total_price"=>12.0, "quantity"=>2.0},
                              {"name"=>"Maki Roll (Seaweed on the Outside)", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Brown Rice on 1 Roll", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"$1.00 (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0},
                              {"name"=>"Soda", "description"=>"Base order item", "price_breakdown"=>"$1.50 (base price)", "category"=>"Prepared Meals", "total_price"=>1.5, "quantity"=>1.0},
                              {"name"=>"Diet Coke", "description"=>"Add-on item (cost inclued in base item total cost)", "price_breakdown"=>"free (add-on price)", "category"=>"Prepared Meals", "total_price"=>0.0, "quantity"=>1.0}
                             ]
                    }
                  ]

  test_receipts.each do |rcpt|

    describe rcpt[:name] do

      before(:all) do
        @results = SeamlessScraper.new(FactoryGirl.build(:email, rcpt[:name])).process_purchase
      end

      it 'should have the correct #vendor' do
        @results.vendor.should eq 'Seamless'
      end

      it 'should have the correct #order_date' do
        @results.order_date.should eq rcpt[:order_date]
      end

      it 'should have the correct #total_price' do
        @results.total_price.should eq rcpt[:total_price]
      end

      it 'should have the correct #sub_vendor' do
        @results.sub_vendor.should eq rcpt[:sub_vendor]
      end

      it 'should have the correct #order_unique_id' do
        @results.order_unique_id.should eq rcpt[:order_unique_id]
      end

      rcpt[:items].each_with_index do |item, index|

        describe "item ##{index}" do

          it 'should have the correct #name' do
            @results.items[index].name.should eq item['name']
          end

          it 'should have the correct #description' do
            @results.items[index].description.should eq item['description']
          end

          it 'should have the correct #price_breakdown' do
            @results.items[index].price_breakdown.should eq item['price_breakdown']
          end

          it 'should have the correct #category' do
            @results.items[index].category.should eq item['category']
          end

          it 'should have the correct #total_price' do
            @results.items[index].total_price.should eq item['total_price']
          end

          it 'should have the correct #quantity' do
            @results.items[index].quantity.should eq item['quantity']
          end

        end

      end

      it "should save the purchase" do
        @results.user = FactoryGirl.create(:user)
        @results.save.should eq true
        @results.items.count.should eq rcpt[:items].count
        @results.items.last.created_at.should_not eq nil
      end

    end

  end

end