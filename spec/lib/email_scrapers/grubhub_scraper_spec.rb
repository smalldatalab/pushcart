require 'spec_helper'

describe GrubhubScraper do

  test_receipts = [
                    {
                      name: :grubhub_receipt_one,
                      total_price: 46.68,
                      sub_vendor: 'Jellyfish',
                      order_unique_id: '55317347',
                      items: [
                              {"name"=>"Black Diamond Roll", "price_breakdown"=>"$19.00", "category"=>"Prepared Meals", "total_price"=>19.0, "quantity"=>1.0},
                              {"name"=>"Fire and Snow Roll", "price_breakdown"=>"$16.00", "category"=>"Prepared Meals", "total_price"=>16.0, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :grubhub_receipt_two,
                      total_price: 33.54,
                      sub_vendor: 'Kodama Sushi',
                      order_unique_id: '596533651',
                      items: [
                              {"name"=>"Hamachi Kama Appetizer[Sea Salt]", "price_breakdown"=>"$8.00", "category"=>"Prepared Meals", "total_price"=>8.0, "quantity"=>1.0},
                              {"name"=>"Yellowtail with Scallion Roll", "price_breakdown"=>"$5.50", "category"=>"Prepared Meals", "total_price"=>5.5, "quantity"=>1.0},
                              {"name"=>"Manhattan Roll", "price_breakdown"=>"$6.50", "category"=>"Prepared Meals", "total_price"=>6.5, "quantity"=>1.0},
                              {"name"=>"Spider Roll", "price_breakdown"=>"$8.00", "category"=>"Prepared Meals", "total_price"=>8.0, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :grubhub_receipt_three,
                      total_price: 42.12,
                      sub_vendor: 'Taste of Thai Express',
                      order_unique_id: '123540506',
                      items: [
                              {"name"=>"Pad See Ew [Mild (1), With Chicken]", "price_breakdown"=>"$8.99", "category"=>"Prepared Meals", "total_price"=>8.99, "quantity"=>1.0},
                              {"name"=>"Masaman Curry[Mild (1), With Chicken]", "price_breakdown"=>"$9.99", "category"=>"Prepared Meals", "total_price"=>9.99, "quantity"=>1.0},
                              {"name"=>"Vegetarian Spring Roll", "price_breakdown"=>"$4.99", "category"=>"Prepared Meals", "total_price"=>4.99, "quantity"=>1.0},
                              {"name"=>"Mixed Vegetable[With Vegetable]", "price_breakdown"=>"$9.49", "category"=>"Prepared Meals", "total_price"=>9.49, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :grubhub_receipt_four,
                      total_price: 15.56,
                      sub_vendor: 'Tiengarden Vegan Kitchen',
                      order_unique_id: '721356257',
                      items: [
                              {"name"=>"Spicy Soy Cutlet[Make it Gluten-Free]mild. not too spicy", "price_breakdown"=>"$13.00", "category"=>"Prepared Meals", "total_price"=>13.0, "quantity"=>1.0}
                             ]
                    }
                  ]

  test_receipts.each do |rcpt|

    describe rcpt[:name] do

      before(:all) do
        @results = GrubhubScraper.new(FactoryGirl.build(:email, rcpt[:name])).process_purchase
      end

      it 'should have the correct #vendor' do
        @results.vendor.should eq 'Grubhub'
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
            @results.items[index].name.should eq item['name']
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