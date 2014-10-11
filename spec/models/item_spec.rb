require 'spec_helper'

describe Item do
  
  describe "servings methods" do

    before(:all) do
      @item = FactoryGirl.build(:item)
    end

    [
      [nil, 1, 0],
      [1, 1, 1],
      [1, nil, 0],
      [nil, nil, 0],
      [83, 81, 6723],
      [83.0, 81, 6723.0],
      [1.3, 2.5, 3.25],
    ].each do |test_set|

      context "when quantity is #{test_set[0]} and servings is #{test_set[1]}" do

        it "should return #{test_set[2]} for #servings_total" do
          @item.stubs(:quantity).returns test_set[0]
          nand = {"nf_servings_per_container" => test_set[1]}
          @item.stubs(:ntx_api_nutrition_data).returns nand
          @item.servings_total.should == test_set[2]
        end

      end

    end

    it "should return nil for #servings_per if no ntx_api_nutrition_data" do
      @item.servings_per.should == nil
    end

  end

end
