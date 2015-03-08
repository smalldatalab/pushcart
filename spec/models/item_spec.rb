require 'spec_helper'

describe Item do

  context 'associations' do

    it { should have_many(:itemizables) }
    it { should have_many(:purchases).through(:itemizables) }
    it { should have_many(:swap_suggestions) }
    it { should have_many(:swaps).through(:swap_suggestions) }

  end

  context 'validations' do

    it { should validate_presence_of(:name) }

  end

  describe "servings methods" do

    before(:all) do
      @item = FactoryGirl.build(:item)
    end

    it "should return nil for #servings_per if no ntx_api_nutrition_data" do
      @item.servings_per.should == nil
    end

  end

end
