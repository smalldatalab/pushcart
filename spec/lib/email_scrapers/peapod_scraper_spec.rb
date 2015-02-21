require 'spec_helper'

describe PeapodScraper do

  test_receipts = [
                    {
                      name: :peapod_receipt_one,
                      total_price: 201.44,
                      order_unique_id: 'j50570360',
                      items: [
                              {"name"=>"Apples Red Delicious", "description"=>"3 LB BAG", "price_breakdown"=>"4.99/ea", "category"=>"Produce Stand", "total_price"=>9.98, "quantity"=>2.0},
                              {"name"=>"Banana Green", "description"=>"1 EA", "price_breakdown"=>".25/ea", "category"=>"Produce Stand", "total_price"=>1.5, "quantity"=>6.0},
                              {"name"=>"Banana Yellow", "description"=>"1 EA", "price_breakdown"=>".25/ea", "category"=>"Produce Stand", "total_price"=>1.0, "quantity"=>4.0},
                              {"name"=>"Broccoli Crowns", "description"=>"1 HEAD", "price_breakdown"=>".79/ea", "category"=>"Produce Stand", "total_price"=>3.16, "quantity"=>4.0},
                              {"name"=>"Celery", "description"=>"1 BUNCH", "price_breakdown"=>"1.99/ea", "category"=>"Produce Stand", "total_price"=>1.99, "quantity"=>1.0},
                              {"name"=>"Clementines Mandarins", "description"=>"3 LB BAG", "price_breakdown"=>"6.99/ea", "category"=>"Produce Stand", "total_price"=>13.98, "quantity"=>2.0},
                              {"name"=>"Cucumbers Mini", "description"=>"14 OZ PKG", "price_breakdown"=>"3.49/ea", "category"=>"Produce Stand", "total_price"=>6.98, "quantity"=>2.0},
                              {"name"=>"Grapes Red Seedless", "description"=>"APX 1 LB", "price_breakdown"=>"1.49/ea", "category"=>"Produce Stand", "total_price"=>1.49, "quantity"=>1.0},
                              {"name"=>"Lettuce Green Leaf", "description"=>"1 HEAD", "price_breakdown"=>"1.79/ea", "category"=>"Produce Stand", "total_price"=>3.58, "quantity"=>2.0},
                              {"name"=>"Tomatoes on the Vine", "description"=>"1 EA", "price_breakdown"=>".69/ea", "category"=>"Produce Stand", "total_price"=>2.07, "quantity"=>3.0},
                              {"name"=>"Bubba Burger Choice Beef Chuck Burgers Original 1/3 lb ea - 6 ct Frozen", "description"=>"2 LB BOX", "price_breakdown"=>"11.99/ea", "category"=>"Meat & Seafood", "total_price"=>11.99, "quantity"=>1.0},
                              {"name"=>"Ground Beef 85% Lean Value Pack Fresh", "description"=>"APX 2.75 LB", "price_breakdown"=>"13.72/ea", "category"=>"Meat & Seafood", "total_price"=>13.72, "quantity"=>1.0},
                              {"name"=>"Stop & Shop Chicken Whole Rotisserie Honey Fully Cooked Refrigerated", "description"=>"APX 2.75 LB", "price_breakdown"=>"5.50/ea", "category"=>"Meat & Seafood", "total_price"=>11.0, "quantity"=>2.0},
                              {"name"=>"Cabot Cheddar Cheese Extra Sharp White Chunk", "description"=>"8 OZ BAR", "price_breakdown"=>"3.69/ea", "category"=>"Dairy", "total_price"=>7.38, "quantity"=>2.0},
                              {"name"=>"Stop & Shop 4 Cheese Blend Mexican Finely Shredded Natural", "description"=>"32 OZ BAG", "price_breakdown"=>"9.29/ea", "category"=>"Dairy", "total_price"=>9.29, "quantity"=>1.0},
                              {"name"=>"Stop & Shop Milk Fat Free", "description"=>"1 GAL", "price_breakdown"=>"4.69/ea", "category"=>"Dairy", "total_price"=>14.07, "quantity"=>3.0},
                              {"name"=>"Stop & Shop Milk Whole Vitamin D", "description"=>"64 OZ JUG", "price_breakdown"=>"3.09/ea", "category"=>"Dairy", "total_price"=>3.09, "quantity"=>1.0},
                              {"name"=>"Stop & Shop Mozzarella String Cheese Part Skim Low Moisture Natural -24 ct", "description"=>"24 OZ PKG", "price_breakdown"=>"8.19/ea", "category"=>"Dairy", "total_price"=>16.38, "quantity"=>2.0},
                              {"name"=>"Breyers Ice Cream Mint Chocolate Chip", "description"=>"1.5 QUART", "price_breakdown"=>"5.49/ea", "category"=>"Frozen Foods", "total_price"=>5.49, "quantity"=>1.0},
                              {"name"=>"Cafe Bustelo Dark Roast Coffee Vacuum Packed (Ground)", "description"=>"10 OZ PKG", "price_breakdown"=>"2.99/ea", "category"=>"Beverages", "total_price"=>5.98, "quantity"=>2.0},
                              {"name"=>"Banquet Brown 'N Serve Turkey Sausage Links - 10 ct Frozen", "description"=>"6.4 OZ BOX", "price_breakdown"=>"1.50/ea", "category"=>"Cereal & Breakfast Foods", "total_price"=>13.5, "quantity"=>9.0},
                              {"name"=>"General Mills Fiber One Chewy Bars Oats & Chocolate - 5 ct", "description"=>"7 OZ BOX", "price_breakdown"=>"3.79/ea", "category"=>"Snacks, Cookies & Candy", "total_price"=>11.37, "quantity"=>3.0},
                              {"name"=>"Kashi Layered Granola Bars Dark Chocolate Coconut All Natural - 6 ct", "description"=>"6.7 OZ BOX", "price_breakdown"=>"3.00/ea", "category"=>"Snacks, Cookies & Candy", "total_price"=>9.0, "quantity"=>3.0},
                              {"name"=>"Keebler Sandwich Crackers Toast & Peanut Butter - 8 ct", "description"=>"11 OZ PKG", "price_breakdown"=>"2.50/ea", "category"=>"Snacks, Cookies & Candy", "total_price"=>5.0, "quantity"=>2.0},
                              {"name"=>"Quaker Rice Cakes White Cheddar", "description"=>"5.46 OZ BAG", "price_breakdown"=>"3.19/ea", "category"=>"Snacks, Cookies & Candy", "total_price"=>6.38, "quantity"=>2.0},
                              {"name"=>"Ortega Taco Shells Yellow Corn - 12 ct", "description"=>"5.8 OZ BOX", "price_breakdown"=>"2.59/ea", "category"=>"Grains, Pasta & Side Dishes", "total_price"=>2.59, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :peapod_receipt_two,
                      total_price: 199.06,
                      order_unique_id: 'j49123888',
                      items: [
                              {"name"=>"Apples Red Delicious", "description"=>"3 LB BAG", "price_breakdown"=>"4.99/ea", "category"=>"Produce Stand", "total_price"=>9.98, "quantity"=>2.0},
                              {"name"=>"Banana Green", "description"=>"1 EA", "price_breakdown"=>".39/ea", "category"=>"Produce Stand", "total_price"=>2.34, "quantity"=>6.0},
                              {"name"=>"Banana Yellow", "description"=>"1 EA", "price_breakdown"=>".39/ea", "category"=>"Produce Stand", "total_price"=>1.56, "quantity"=>4.0},
                              {"name"=>"Broccoli Crowns", "description"=>"1 HEAD", "price_breakdown"=>".79/ea", "category"=>"Produce Stand", "total_price"=>3.16, "quantity"=>4.0},
                              {"name"=>"Celery", "description"=>"1 BUNCH", "price_breakdown"=>"1.99/ea", "category"=>"Produce Stand", "total_price"=>1.99, "quantity"=>1.0},
                              {"name"=>"Clementines Mandarins", "description"=>"3 LB BAG", "price_breakdown"=>"6.99/ea", "category"=>"Produce Stand", "total_price"=>13.98, "quantity"=>2.0},
                              {"name"=>"Cucumbers Mini", "description"=>"14 OZ PKG", "price_breakdown"=>"3.49/ea", "category"=>"Produce Stand", "total_price"=>6.98, "quantity"=>2.0},
                              {"name"=>"Lettuce Green Leaf", "description"=>"1 HEAD", "price_breakdown"=>"1.79/ea", "category"=>"Produce Stand", "total_price"=>3.58, "quantity"=>2.0},
                              {"name"=>"Tomatoes on the Vine", "description"=>"1 EA", "price_breakdown"=>".89/ea", "category"=>"Produce Stand", "total_price"=>2.67, "quantity"=>3.0},
                              {"name"=>"Bubba Burger Choice Beef Chuck Burgers Original 1/3 lb ea - 6 ct Frozen", "description"=>"2 LB BOX", "price_breakdown"=>"12.49/ea", "category"=>"Meat & Seafood", "total_price"=>12.49, "quantity"=>1.0},
                              {"name"=>"Ground Beef 85% Lean Value Pack Fresh", "description"=>"APX 2.5 LB", "price_breakdown"=>"9.98/ea", "category"=>"Meat & Seafood", "total_price"=>9.98, "quantity"=>1.0},
                              {"name"=>"Stop & Shop Bacon Lower Sodium", "description"=>"16 OZ PKG", "price_breakdown"=>"5.49/ea", "category"=>"Meat & Seafood", "total_price"=>10.98, "quantity"=>2.0},
                              {"name"=>"Stop & Shop Chicken Whole Rotisserie Honey Fully Cooked Refrigerated", "description"=>"APX 2.75 LB", "price_breakdown"=>"6.49/ea", "category"=>"Meat & Seafood", "total_price"=>12.98, "quantity"=>2.0},
                              {"name"=>"Cabot Cheddar Cheese Extra Sharp White Chunk", "description"=>"8 OZ BAR", "price_breakdown"=>"3.54/ea", "category"=>"Dairy", "total_price"=>7.08, "quantity"=>2.0},
                              {"name"=>"Stop & Shop 4 Cheese Blend Mexican Finely Shredded Natural", "description"=>"32 OZ BAG", "price_breakdown"=>"9.29/ea", "category"=>"Dairy", "total_price"=>9.29, "quantity"=>1.0},
                              {"name"=>"Stop & Shop Milk Fat Free", "description"=>"1 GAL", "price_breakdown"=>"4.49/ea", "category"=>"Dairy", "total_price"=>13.47, "quantity"=>3.0},
                              {"name"=>"Stop & Shop Milk Whole Vitamin D", "description"=>"64 OZ JUG", "price_breakdown"=>"2.89/ea", "category"=>"Dairy", "total_price"=>2.89, "quantity"=>1.0},
                              {"name"=>"Stop & Shop Mozzarella String Cheese Part Skim Low Moisture Natural -24 ct", "description"=>"24 OZ PKG", "price_breakdown"=>"8.19/ea", "category"=>"Dairy", "total_price"=>16.38, "quantity"=>2.0},
                              {"name"=>"Breyers Ice Cream Mint Chocolate Chip", "description"=>"1.5 QUART", "price_breakdown"=>"5.49/ea", "category"=>"Frozen Foods", "total_price"=>5.49, "quantity"=>1.0},
                              {"name"=>"Cafe Bustelo Dark Roast Coffee Vacuum Packed (Ground)", "description"=>"10 OZ PKG", "price_breakdown"=>"2.99/ea", "category"=>"Beverages", "total_price"=>5.98, "quantity"=>2.0},
                              {"name"=>"Calise & Sons Bakery Bulkie Rolls - 6 ct", "description"=>"13 OZ BAG", "price_breakdown"=>"2.50/ea", "category"=>"Bread & Bakeshop", "total_price"=>5.0, "quantity"=>2.0},
                              {"name"=>"General Mills Fiber One Chewy Bars Oats & Chocolate - 5 ct", "description"=>"7 OZ BOX", "price_breakdown"=>"3.79/ea", "category"=>"Snacks, Cookies & Candy", "total_price"=>11.37, "quantity"=>3.0},
                              {"name"=>"Kashi Layered Granola Bars Dark Chocolate Coconut All Natural - 6 ct", "description"=>"6.7 OZ BOX", "price_breakdown"=>"3.00/ea", "category"=>"Snacks, Cookies & Candy", "total_price"=>6.0, "quantity"=>2.0},
                              {"name"=>"Keebler Sandwich Crackers Toast & Peanut Butter - 8 ct", "description"=>"11 OZ PKG", "price_breakdown"=>"2.50/ea", "category"=>"Snacks, Cookies & Candy", "total_price"=>5.0, "quantity"=>2.0},
                              {"name"=>"Quaker Rice Cakes White Cheddar", "description"=>"5.46 OZ BAG", "price_breakdown"=>"3.19/ea", "category"=>"Snacks, Cookies & Candy", "total_price"=>6.38, "quantity"=>2.0},
                              {"name"=>"Ortega Taco Shells Yellow Corn - 12 ct", "description"=>"5.8 OZ BOX", "price_breakdown"=>"2.59/ea", "category"=>"Grains, Pasta & Side Dishes", "total_price"=>2.59, "quantity"=>1.0}
                             ]
                    },
                    {
                      name: :peapod_receipt_three,
                      total_price: 174.69,
                      order_unique_id: 'j48340159',
                      items: [
                              {"name"=>"Apples Gala", "description"=>"5 LB BAG", "price_breakdown"=>"5.99/ea", "category"=>"Produce Stand", "total_price"=>5.99, "quantity"=>1.0},
                              {"name"=>"Banana Green", "description"=>"1 EA", "price_breakdown"=>".25/ea", "category"=>"Produce Stand", "total_price"=>1.75, "quantity"=>7.0},
                              {"name"=>"Banana Yellow", "description"=>"1 EA", "price_breakdown"=>".25/ea", "category"=>"Produce Stand", "total_price"=>0.5, "quantity"=>2.0},
                              {"name"=>"Broccoli Crowns", "description"=>"1 HEAD", "price_breakdown"=>".99/ea", "category"=>"Produce Stand", "total_price"=>3.96, "quantity"=>4.0},
                              {"name"=>"Carrots Baby Cut Peeled Stop & Shop", "description"=>"16 OZ BAG", "price_breakdown"=>"1.00/ea", "category"=>"Produce Stand", "total_price"=>1.0, "quantity"=>1.0},
                              {"name"=>"Celery", "description"=>"1 BUNCH", "price_breakdown"=>"1.99/ea", "category"=>"Produce Stand", "total_price"=>1.99, "quantity"=>1.0},
                              {"name"=>"Cucumbers Mini", "description"=>"14 OZ PKG", "price_breakdown"=>"3.49/ea", "category"=>"Produce Stand", "total_price"=>6.98, "quantity"=>2.0},
                              {"name"=>"Garlic Bulk", "description"=>"1 HEAD", "price_breakdown"=>".50/ea", "category"=>"Produce Stand", "total_price"=>1.0, "quantity"=>2.0},
                              {"name"=>"Grapes Green Seedless", "description"=>"APX 1 LB", "price_breakdown"=>"1.49/ea", "category"=>"Produce Stand", "total_price"=>2.98, "quantity"=>2.0},
                              {"name"=>"Greens Kale Organic", "description"=>"1 BUNCH", "price_breakdown"=>"1.99/ea", "category"=>"Produce Stand", "total_price"=>1.99, "quantity"=>1.0},
                              {"name"=>"Lettuce Green Leaf", "description"=>"1 HEAD", "price_breakdown"=>"1.79/ea", "category"=>"Produce Stand", "total_price"=>3.58, "quantity"=>2.0},
                              {"name"=>"Mushrooms White Whole Stop & Shop", "description"=>"8 OZ PKG", "price_breakdown"=>"1.00/ea", "category"=>"Produce Stand", "total_price"=>1.0, "quantity"=>1.0},
                              {"name"=>"Onions Vidalia", "description"=>"1 EA", "price_breakdown"=>"1.29/ea", "category"=>"Produce Stand", "total_price"=>1.29, "quantity"=>1.0},
                              {"name"=>"Peppers Bell Red Guaranteed Value", "description"=>"2 LB PKG", "price_breakdown"=>"3.99/ea", "category"=>"Produce Stand", "total_price"=>3.99, "quantity"=>1.0},
                              {"name"=>"Bubba Burger Choice Beef Chuck Burgers Original 1/3 lb ea - 6 ct Frozen", "description"=>"2 LB BOX", "price_breakdown"=>"10.99/ea", "category"=>"Meat & Seafood", "total_price"=>10.99, "quantity"=>1.0},
                              {"name"=>"Ground Beef 90% Lean Fresh", "description"=>"APX 1.1 LB", "price_breakdown"=>"4.94/ea", "category"=>"Meat & Seafood", "total_price"=>9.88, "quantity"=>2.0},
                              {"name"=>"Hebrew National Beef Franks 97% Fat Free - 7 ct", "description"=>"11 OZ PKG", "price_breakdown"=>"3.00/ea", "category"=>"Meat & Seafood", "total_price"=>3.0, "quantity"=>1.0},
                              {"name"=>"Perdue Fit & Easy Chicken Breasts Boneless Skinless Natural - 2-3 ct Fresh", "description"=>"APX 1.5 LB", "price_breakdown"=>"7.36/ea", "category"=>"Meat & Seafood", "total_price"=>7.36, "quantity"=>1.0},
                              {"name"=>"Shady Brook Farms Turkey Ground 93% Fat Free All Natural Fresh", "description"=>"20.8 OZ PKG", "price_breakdown"=>"3.99/ea", "category"=>"Meat & Seafood", "total_price"=>3.99, "quantity"=>1.0},
                              {"name"=>"Boar's Head Deli Turkey Breast Mesquite Wood Smoked (Thin Sliced)", "description"=>"APX 1/2 LB", "price_breakdown"=>"4.89/ea", "category"=>"Deli", "total_price"=>9.79, "quantity"=>2.0},
                              {"name"=>"Eat Well Embrace Life White Bean Hummus Roasted Pine Nuts & Herbs", "description"=>"10 OZ PKG", "price_breakdown"=>"3.99/ea", "category"=>"Deli", "total_price"=>3.99, "quantity"=>1.0},
                              {"name"=>"Simply Enjoy Hummus Roasted Garlic", "description"=>"10 OZ TUB", "price_breakdown"=>"3.00/ea", "category"=>"Deli", "total_price"=>3.0, "quantity"=>1.0},
                              {"name"=>"Stop & Shop Ham Black Forest Thin Sliced", "description"=>"9 OZ TUB", "price_breakdown"=>"2.50/ea", "category"=>"Deli", "total_price"=>2.5, "quantity"=>1.0},
                              {"name"=>"Cabot Cheddar Cheese Seriously Sharp White Chunk", "description"=>"8 OZ BAR", "price_breakdown"=>"3.54/ea", "category"=>"Dairy", "total_price"=>7.08, "quantity"=>2.0},
                              {"name"=>"Cabot Greek Style Yogurt Vanilla Bean Low Fat", "description"=>"32 OZ TUB", "price_breakdown"=>"3.99/ea", "category"=>"Dairy", "total_price"=>3.99, "quantity"=>1.0},
                              {"name"=>"Dannon Oikos Fruit on the Bottom Greek Yogurt Blueberry Non Fat", "description"=>"5.3 OZ CUP", "price_breakdown"=>"1.00/ea", "category"=>"Dairy", "total_price"=>1.0, "quantity"=>1.0},
                              {"name"=>"Dannon Oikos Fruit on the Bottom Greek Yogurt Peach Non Fat", "description"=>"5.3 OZ CUP", "price_breakdown"=>"1.00/ea", "category"=>"Dairy", "total_price"=>1.0, "quantity"=>1.0},
                              {"name"=>"Dannon Oikos Greek Yogurt Vanilla Non Fat", "description"=>"5.3 OZ CUP", "price_breakdown"=>"1.00/ea", "category"=>"Dairy", "total_price"=>2.0, "quantity"=>2.0},
                              {"name"=>"Dannon Oikos Traditional Greek Yogurt Banana Cream", "description"=>"5.3 OZ CUP", "price_breakdown"=>"1.00/ea", "category"=>"Dairy", "total_price"=>1.0, "quantity"=>1.0},
                              {"name"=>"Dannon Oikos Traditional Greek Yogurt Key Lime", "description"=>"5.3 OZ CUP", "price_breakdown"=>"1.00/ea", "category"=>"Dairy", "total_price"=>1.0, "quantity"=>1.0},
                              {"name"=>"Birds Eye Deluxe Baby Corn Gold & White All Natural", "description"=>"16 OZ BAG", "price_breakdown"=>"2.00/ea", "category"=>"Frozen Foods", "total_price"=>2.0, "quantity"=>1.0},
                              {"name"=>"Birds Eye Steamfresh Premium Selects Green Beans Whole All Natural", "description"=>"12 OZ BAG", "price_breakdown"=>"2.00/ea", "category"=>"Frozen Foods", "total_price"=>4.0, "quantity"=>2.0},
                              {"name"=>"Cooked Perfect Meatballs Italian Style Bite Size Frozen", "description"=>"48 OZ BAG", "price_breakdown"=>"8.99/ea", "category"=>"Frozen Foods", "total_price"=>8.99, "quantity"=>1.0},
                              {"name"=>"Newman's Own Pizza Margherita Thin & Crispy All Natural Frozen", "description"=>"13.9 OZ BOX", "price_breakdown"=>"5.50/ea", "category"=>"Frozen Foods", "total_price"=>5.5, "quantity"=>1.0},
                              {"name"=>"Stop & Shop Churn Style Ice Cream Moose Tracks Light", "description"=>"1.5 QUART", "price_breakdown"=>"2.39/ea", "category"=>"Frozen Foods", "total_price"=>2.39, "quantity"=>1.0},
                              {"name"=>"Stop & Shop Real Premium Ice Cream Mint Chocolate Chip", "description"=>"1.5 QUART", "price_breakdown"=>"2.39/ea", "category"=>"Frozen Foods", "total_price"=>2.39, "quantity"=>1.0},
                              {"name"=>"Annie's Homegrown Macaroni & Cheese Made with Organic Pasta Natural", "description"=>"6 OZ BOX", "price_breakdown"=>"1.89/ea", "category"=>"Grains, Pasta & Side Dishes", "total_price"=>1.89, "quantity"=>1.0},
                              {"name"=>"Near East Rice Pilaf Mix Original 100% Natural", "description"=>"6.09 OZ BOX", "price_breakdown"=>"1.00/ea", "category"=>"Grains, Pasta & Side Dishes", "total_price"=>2.0, "quantity"=>2.0},
                              {"name"=>"Old El Paso Dinner Kit Taco - 12 ct", "description"=>"8.8 OZ BOX", "price_breakdown"=>"2.50/ea", "category"=>"Grains, Pasta & Side Dishes", "total_price"=>5.0, "quantity"=>2.0},
                              {"name"=>"Ronzoni Garden Delight Pasta Spaghetti Enriched Tomato Carrot & Spinach", "description"=>"12 OZ BOX", "price_breakdown"=>"1.00/ea", "category"=>"Grains, Pasta & Side Dishes", "total_price"=>2.0, "quantity"=>2.0},
                              {"name"=>"Stop & Shop Pasta Cavatappi", "description"=>"16 OZ BOX", "price_breakdown"=>".88/ea", "category"=>"Grains, Pasta & Side Dishes", "total_price"=>1.76, "quantity"=>2.0},
                              {"name"=>"Nature's Promise Organics Peanut Butter Smooth", "description"=>"16 OZ JAR", "price_breakdown"=>"4.69/ea", "category"=>"Condiments, Oils & Dressings", "total_price"=>4.69, "quantity"=>1.0}
                             ]
                    }
                  ]

  test_receipts.each do |rcpt|

    describe rcpt[:name] do

      before(:all) do
        @results = PeapodScraper.new(FactoryGirl.build(:email, rcpt[:name])).process_purchase
      end

      it 'should have the correct #vendor' do
        @results.vendor.should eq 'Peapod'
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
      # @results.items.map {|i| p i.attributes.delete_if { |k,v| ['id', 'purchase_id', "discounted", "created_at", "updated_at", "ntx_api_nutrition_data", "ntx_api_metadata", "color_code"].include? k }}

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