require 'spec_helper'

describe CaviarScraper do

  test_receipts = [
                    {
                      name: :caviar_receipt_one,
                      total_price: 32.59,
                      sub_vendor: "Mighty Quinn's Barbeque",
                      order_unique_id: 'U3tBR2Gu',
                      items: [
                              {"name"=>"Spare Ribs", "description"=>"Cucumbers; Half Rack (6 ribs); Vinegar Slaw", "price_breakdown"=>"$12.00", "category"=>"Prepared Meals", "total_price"=>12.0, "quantity"=>1.0},
                              {"name"=>"Buttermilk Broccoli", "description"=>"Medium", "price_breakdown"=>"$6.25", "category"=>"Prepared Meals", "total_price"=>6.25, "quantity"=>1.0},
                              {"name"=>"Sweet Corn Fritters", "description"=>"Small", "price_breakdown"=>"$3.50", "category"=>"Prepared Meals", "total_price"=>3.5, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :caviar_receipt_two,
                      total_price: 35.76,
                      sub_vendor: "Otto's Tacos",
                      order_unique_id: 'svNeeJwH',
                      items: [
                              {"name"=>"Carne Asada Taco", "description"=>"Green Salsa; Add Guacamole", "price_breakdown"=>"$15.00", "category"=>"Prepared Meals", "total_price"=>15.0, "quantity"=>4.0},
                              {"name"=>"Carnitas Taco", "description"=>"Green Salsa; Add Guacamole", "price_breakdown"=>"$3.50", "category"=>"Prepared Meals", "total_price"=>3.5, "quantity"=>1.0},
                              {"name"=>"Chips & Guacamole", "description"=>"Green Salsa", "price_breakdown"=>"$3.75", "category"=>"Prepared Meals", "total_price"=>3.75, "quantity"=>1.0},
                              {"name"=>"Chips & Salsa", "description"=>nil, "price_breakdown"=>"$2.00", "category"=>"Prepared Meals", "total_price"=>2.0, "quantity"=>1.0}
                             ]
                    }
                  ]

  test_receipts.each do |rcpt|

    describe rcpt[:name] do

      before(:all) do
        @results = CaviarScraper.new(FactoryGirl.build(:email, rcpt[:name])).process_purchase
      end

      it 'should have the correct #vendor' do
        @results.vendor.should eq 'Caviar'
      end

      # it 'should have the correct #order_date' do
      #   @results.order_date.should eq rcpt[:order_date]
      # end

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
            @results.itemizables[index].item.name.should eq item['name']
          end

          it 'should have the correct #description' do
            @results.itemizables[index].item.description.should eq item['description']
          end

          it 'should have the correct #price_breakdown' do
            @results.itemizables[index].price_breakdown.should eq item['price_breakdown']
          end

          it 'should have the correct #category' do
            @results.itemizables[index].item.category.should eq item['category']
          end

          it 'should have the correct #total_price' do
            @results.itemizables[index].total_price.should eq item['total_price']
          end

          it 'should have the correct #quantity' do
            @results.itemizables[index].quantity.should eq item['quantity']
          end

        end

      end

      it "should save the purchase" do
        @results.user = FactoryGirl.create(:user)
        @results.save.should eq true
        @results.itemizables.count.should eq rcpt[:items].count
        @results.itemizables.last.created_at.should_not eq nil
      end

    end

  end

end