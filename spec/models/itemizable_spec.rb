require 'spec_helper'

describe Itemizable do

  context 'associations' do

    it { should belong_to(:item) }
    it { should belong_to(:purchase) }
    it { should have_one(:user).through(:purchase) }

  end

  context 'validations' do

    it { should validate_presence_of(:item) }
    it { should validate_presence_of(:purchase) }

  end

  describe "servings methods" do

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
          nand = {"nf_servings_per_container" => test_set[1]}
          @item = FactoryGirl.build(:item, ntx_api_nutrition_data: nand)

          @itemizable = FactoryGirl.build(:itemizable, item: @item, quantity: test_set[0])

          @itemizable.servings_total.should == test_set[2]
        end

      end

    end

  end

end
