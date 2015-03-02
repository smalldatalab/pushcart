require 'spec_helper'

describe FreshDirectScraper do

  test_receipts = [
                    {
                      name: :fresh_direct_receipt_one,
                      total_price: 140.18,
                      order_unique_id: '15332604723',
                      items: [
                              {"name"=>"Poland Spring Natural Spring Water Gallon Bottles, Case", "description"=>"1 gal bottles, 6 per case", "price_breakdown"=>"8.99/cs", "category"=>"Buy Big", "total_price"=>8.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"San Pellegrino Sparkling Natural Mineral Water, Case", "description"=>"25.3oz bottles", "price_breakdown"=>"27.99/cs", "category"=>"Buy Big", "total_price"=>27.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Fage TOTAL 0% Greek Yogurt with Cherry Pomegranate", "description"=>"5.3oz", "price_breakdown"=>"1.80/ea", "category"=>"Dairy", "total_price"=>3.6, "quantity"=>2.0, "discounted"=>true},
                              {"name"=>"Fage TOTAL 0% Greek Yogurt with Honey", "description"=>"5.3oz", "price_breakdown"=>"1.80/ea", "category"=>"Dairy", "total_price"=>3.6, "quantity"=>2.0, "discounted"=>true},
                              {"name"=>"Fage TOTAL 0% Greek Yogurt with Raspberry", "description"=>"5.3oz", "price_breakdown"=>"1.80/ea", "category"=>"Dairy", "total_price"=>3.6, "quantity"=>2.0, "discounted"=>true},
                              {"name"=>"Fage TOTAL 0% Plain Greek Yogurt", "description"=>"17.6oz", "price_breakdown"=>"3.99/ea", "category"=>"Dairy", "total_price"=>3.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Organic Valley Nonfat Milk", "description"=>"1/2 gallon", "price_breakdown"=>"4.99/ea", "category"=>"Dairy", "total_price"=>9.98, "quantity"=>2.0, "discounted"=>false},
                              {"name"=>"Lemons", "description"=>"Farm Fresh, Med", "price_breakdown"=>"0.99/ea", "category"=>"Fruit", "total_price"=>1.98, "quantity"=>2.0, "discounted"=>false},
                              {"name"=>"Limes", "description"=>"Farm Fresh", "price_breakdown"=>"0.49/ea", "category"=>"Fruit", "total_price"=>0.98, "quantity"=>2.0, "discounted"=>false},
                              {"name"=>"Bel Aria Grapeseed Oil", "description"=>"17oz", "price_breakdown"=>"4.99/ea", "category"=>"Grocery", "total_price"=>4.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Cascade Lemon Automatic Dishwasher Liquigel", "description"=>"45oz", "price_breakdown"=>"4.99/ea", "category"=>"Grocery", "total_price"=>4.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Kettle Bakes Lightly Salted Potato Chips", "description"=>"4oz", "price_breakdown"=>"3.19/ea", "category"=>"Grocery", "total_price"=>3.19, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Lysol Power Toilet Bowl Cleaner", "description"=>"16oz", "price_breakdown"=>"2.49/ea", "category"=>"Grocery", "total_price"=>2.49, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Melitta #4 Natural Brown Coffee Filters", "description"=>"100 ct", "price_breakdown"=>"4.79/ea", "category"=>"Grocery", "total_price"=>4.79, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Planters Peanut Oil", "description"=>"24oz", "price_breakdown"=>"5.59/ea", "category"=>"Grocery", "total_price"=>5.59, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Popchips All Natural Popped Chip Snack, Chili Lime Potato", "description"=>"3oz", "price_breakdown"=>"2.99/ea", "category"=>"Grocery", "total_price"=>2.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Viva 1-Ply Choose-A-Size Paper Towels, 8 Giant Rolls", "description"=>"100 sheets per roll", "price_breakdown"=>"15.99/ea", "category"=>"Grocery", "total_price"=>15.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Xochitl Mexican Style Tortilla Chips, Salted", "description"=>"16oz", "price_breakdown"=>"4.69/ea", "category"=>"Grocery", "total_price"=>4.69, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Method Foam Hand Wash, Sweet Water, Refill", "description"=>"28oz", "price_breakdown"=>"6.59/ea", "category"=>"Health & Beauty", "total_price"=>6.59, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Kashi Organic Promise Strawberry Fields Cereal", "description"=>"10.3oz", "price_breakdown"=>"4.79/ea", "category"=>"Organic & All-Natural", "total_price"=>4.79, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Fresh Step Premium Scoopable Clumping Cat Litter", "description"=>"7lbs", "price_breakdown"=>"5.99/ea", "category"=>"Pet", "total_price"=>5.99, "quantity"=>1.0, "discounted"=>false}
                             ]
                    },
                    {
                      name: :fresh_direct_receipt_two,
                      total_price: 109.1,
                      order_unique_id: '15326042883',
                      items: [
                              {"name"=>"San Pellegrino Sparkling Natural Mineral Water, Case", "description"=>"25.3oz bottles", "price_breakdown"=>"27.99/cs", "category"=>"Buy Big", "total_price"=>27.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Fage TOTAL 0% Greek Yogurt with Cherry Pomegranate", "description"=>"5.3oz", "price_breakdown"=>"1.99/ea", "category"=>"Dairy", "total_price"=>3.98, "quantity"=>2.0, "discounted"=>false},
                              {"name"=>"Fage TOTAL 0% Greek Yogurt with Honey", "description"=>"5.3oz", "price_breakdown"=>"1.99/ea", "category"=>"Dairy", "total_price"=>3.98, "quantity"=>2.0, "discounted"=>false},
                              {"name"=>"Fage TOTAL 0% Greek Yogurt with Raspberry", "description"=>"5.3oz", "price_breakdown"=>"1.99/ea", "category"=>"Dairy", "total_price"=>3.98, "quantity"=>2.0, "discounted"=>false},
                              {"name"=>"Organic Valley Nonfat Milk", "description"=>"1/2 gallon", "price_breakdown"=>"4.99/ea", "category"=>"Dairy", "total_price"=>9.98, "quantity"=>2.0, "discounted"=>false},
                              {"name"=>"POM Wonderful 100% Pomegranate Juice", "description"=>"16oz", "price_breakdown"=>"3.99/ea", "category"=>"Dairy", "total_price"=>3.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Dole Mango Chunks, Frozen", "description"=>"16oz", "price_breakdown"=>"4.49/ea", "category"=>"Frozen", "total_price"=>4.49, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Marie Callendar's Chicken Pot Pie", "description"=>"16oz", "price_breakdown"=>"4.69/ea", "category"=>"Frozen", "total_price"=>4.69, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Lemons", "description"=>"Farm Fresh, Med", "price_breakdown"=>"0.99/ea", "category"=>"Fruit", "total_price"=>1.98, "quantity"=>2.0, "discounted"=>false},
                              {"name"=>"Limes", "description"=>"Farm Fresh", "price_breakdown"=>"0.59/ea", "category"=>"Fruit", "total_price"=>1.18, "quantity"=>2.0, "discounted"=>false},
                              {"name"=>"Kashi Heart to Heart Cereal, Honey Toasted", "description"=>"12oz", "price_breakdown"=>"4.49/ea", "category"=>"Grocery", "total_price"=>4.49, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Kettle Bakes Lightly Salted Potato Chips", "description"=>"4oz", "price_breakdown"=>"3.19/ea", "category"=>"Grocery", "total_price"=>3.19, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Popchips All Natural Popped Chip Snack, Chili Lime Potato", "description"=>"3oz", "price_breakdown"=>"2.99/ea", "category"=>"Grocery", "total_price"=>2.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Puffs Plus Lotion 2-Ply Facial Tissue, 4 Cube Boxes", "description"=>"56 tissues per box", "price_breakdown"=>"6.23/ea", "category"=>"Grocery", "total_price"=>6.23, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Colgate Total Anticavity Fluoride & Antigingivitis Advanced Whitening Toothpaste", "description"=>"5.8oz", "price_breakdown"=>"4.99/ea", "category"=>"Health & Beauty", "total_price"=>4.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Rao's Homemade Marinara Sauce", "description"=>"32oz", "price_breakdown"=>"9.49/ea", "category"=>"Pasta", "total_price"=>9.49, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Fresh Step Premium Scoopable Clumping Cat Litter", "description"=>"7lbs", "price_breakdown"=>"5.99/ea", "category"=>"Pet", "total_price"=>5.99, "quantity"=>1.0, "discounted"=>false}
                             ]
                    },
                    {
                      name: :fresh_direct_receipt_three,
                      total_price: 115.89,
                      order_unique_id: '15482058472',
                      items: [
                              {"name"=>"Poland Spring Natural Spring Water Gallon Bottles, Case", "description"=>"1 gal bottles, 6 per case", "price_breakdown"=>"8.99/cs", "category"=>"Buy Big", "total_price"=>8.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"San Pellegrino Sparkling Natural Mineral Water, Case", "description"=>"25.3oz bottles", "price_breakdown"=>"27.99/cs", "category"=>"Buy Big", "total_price"=>27.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Fage TOTAL 0% Plain Greek Yogurt", "description"=>"17.6oz", "price_breakdown"=>"3.99/ea", "category"=>"Dairy", "total_price"=>3.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Organic Valley Nonfat Milk", "description"=>"1/2 gallon", "price_breakdown"=>"5.19/ea", "category"=>"Dairy", "total_price"=>5.19, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Sky Top Farms Unhomogenized Organic Grass-Fed Whole Milk", "description"=>"32oz", "price_breakdown"=>"3.99/ea", "category"=>"Dairy", "total_price"=>3.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Cascade 2 in 1 ActionPacs Dish Detergent", "description"=>"20ct", "price_breakdown"=>"6.74/ea", "category"=>"Household", "total_price"=>6.74, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Bison Rib Eye Steak", "description"=>"10oz", "price_breakdown"=>"16.99/ea", "category"=>"Meat", "total_price"=>16.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Kashi Organic Promise Strawberry Fields Cereal", "description"=>"10.3oz", "price_breakdown"=>"4.79/ea", "category"=>"Organic & All-Natural", "total_price"=>4.79, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Kind Nuts & Spices, Dark Chocolate Nuts & Sea Salt", "description"=>"12ct, 1.4oz ea", "price_breakdown"=>"21.99/ea", "category"=>"Pantry", "total_price"=>21.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Popchips All-Natural Popped Chip Snack, Barbeque Potato", "description"=>"3.5oz", "price_breakdown"=>"2.99/ea", "category"=>"Pantry", "total_price"=>2.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Fresh Step Premium Scoopable Clumping Cat Litter", "description"=>"7lbs", "price_breakdown"=>"5.99/ea", "category"=>"Pet Care", "total_price"=>5.99, "quantity"=>1.0, "discounted"=>false}
                             ]
                    },
                    {
                      name: :fresh_direct_receipt_four,
                      total_price: 75.87,
                      order_unique_id: '15483995042',
                      items: [
                              {"name"=>"Breakstone's 2% Small Curd Cottage Cheese", "description"=>"4oz. 4ct.", "price_breakdown"=>"3.99/ea", "category"=>"Dairy", "total_price"=>3.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Egg Beaters All Natural Egg White", "description"=>"3pk", "price_breakdown"=>"3.59/ea", "category"=>"Dairy", "total_price"=>14.36, "quantity"=>4.0, "discounted"=>false},
                              {"name"=>"Fage TOTAL 0% Plain Greek Yogurt", "description"=>"17.6oz", "price_breakdown"=>"3.99/ea", "category"=>"Dairy", "total_price"=>23.94, "quantity"=>6.0, "discounted"=>false},
                              {"name"=>"Land O'Lakes Fat-Free Half & Half", "description"=>"1 pint", "price_breakdown"=>"2.49/ea", "category"=>"Dairy", "total_price"=>4.98, "quantity"=>2.0, "discounted"=>false},
                              {"name"=>"The Laughing Cow Light Original Swiss Spreadable Cheese Wedges", "description"=>"6oz", "price_breakdown"=>"3.99/ea", "category"=>"Dairy", "total_price"=>3.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Family Tree Farms Purple Rose Aprium", "description"=>nil, "price_breakdown"=>"2.99/lb", "category"=>"Fruit", "total_price"=>1.79, "quantity"=>2.0, "discounted"=>true},
                              {"name"=>"Red Cherries", "description"=>"each, Farm Fresh", "price_breakdown"=>"2.99/lb", "category"=>"Fruit", "total_price"=>5.98, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Wild Harvest Organic Medium Thick & Chunky Salsa", "description"=>"16oz", "price_breakdown"=>"3.29/ea", "category"=>"Pantry", "total_price"=>9.87, "quantity"=>3.0, "discounted"=>false}
                             ]
                    },
                    {
                      name: :fresh_direct_gmail_api_receipt_one,
                      total_price: 36.73,
                      order_unique_id: '15606538705',
                      items: [
                              {"name"=>"Blue Diamond Almond Breeze Almond Milk, Vanilla", "description"=>"32oz carton", "price_breakdown"=>"2.25/ea", "category"=>"Dairy", "total_price"=>9.0, "quantity"=>4.0, "discounted"=>true},
                              {"name"=>"Udi's Gluten Free Whole Grain Bread Loaf, Frozen", "description"=>"12oz", "price_breakdown"=>"5.29/ea", "category"=>"Frozen", "total_price"=>5.29, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Grady's All Natural Cold Brew Coffee Concentrate", "description"=>"32oz", "price_breakdown"=>"12.99/ea", "category"=>"Pantry", "total_price"=>12.99, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Nature's Path Organic Flax Plus Pumpkin Raisin Crunch", "description"=>"10.6oz", "price_breakdown"=>"4.29/ea", "category"=>"Pantry", "total_price"=>4.29, "quantity"=>1.0, "discounted"=>false},
                              {"name"=>"Organic Baby Bok Choy", "description"=>nil, "price_breakdown"=>"2.99/lb", "category"=>"Vegetables", "total_price"=>4.78, "quantity"=>2.0, "discounted"=>true}
                             ]
                    }
                  ]

  test_receipts.each do |rcpt|

    describe rcpt[:name] do

      before(:all) do
        @results = FreshDirectScraper.new(FactoryGirl.build(:email, rcpt[:name])).process_purchase
      end

      it 'should have the correct #vendor' do
        @results.vendor.should eq 'Fresh Direct'
      end

      # it 'should have the correct #order_date' do
      #   @results.order_date.should eq rcpt[:order_date]
      # end

      it 'should have the correct #total_price' do
        @results.total_price.should eq rcpt[:total_price]
      end

      it 'should have the correct #order_unique_id' do
        @results.order_unique_id.should eq rcpt[:order_unique_id]
      end

      ### For getting items hashes
      # @results.items.map {|i| p i.attributes.delete_if { |k,v| ['id', 'purchase_id', "created_at", "updated_at", "ntx_api_nutrition_data", "ntx_api_metadata", "color_code"].include? k }}

      rcpt[:items].each_with_index do |item, index|

        describe "item ##{index}" do

          it 'should have the correct #name' do
            @results.items[index].name.should eq item['name']
          end

          it 'should have the correct #price_breakdown' do
            @results.items[index].price_breakdown.should eq item['price_breakdown']
          end

          it 'should have the correct #discounted' do
            @results.items[index].discounted.should eq item['discounted']
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