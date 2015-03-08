require 'spec_helper'

describe EmailScraper do

  describe "#evaluate_and_process" do

    before(:each) do
      @ie = FactoryGirl.create(:message)
    end

    it "should change the message state to processed" do
      @ie.successfully_processed.should == false

      EmailScraper.new(@ie.id)

      @ie.successfully_processed.should == true
    end

    # it "should send right mailer if user is not found" do
    #   @ie.successfully_processed.should == false

    #   EmailScraper.new(@ie.id)

    #   @ie.successfully_processed.should == true
    # end

  end

  describe '#determine_scraper' do

    before(:all) do
      @scraper = EmailScraper.new(FactoryGirl.create(:message).id)
    end

    [
      [:fresh_direct_receipt_one, :fresh_direct],
      [:fresh_direct_receipt_two, :fresh_direct],
      [:fresh_direct_receipt_three, :fresh_direct],
      [:fresh_direct_receipt_four, :fresh_direct],
      [:instacart_receipt, :instacart],
      [:peapod_receipt_one, :peapod],
      [:peapod_receipt_two, :peapod],
      [:peapod_receipt_three, :peapod],
      [:seamless_receipt_one, :seamless],
      [:seamless_receipt_two, :seamless],
      [:seamless_receipt_three, :seamless],
      [:seamless_receipt_four, :seamless],
      [:seamless_receipt_five, :seamless],
      [:seamless_receipt_six, :seamless],
      [:seamless_receipt_seven, :seamless],
      [:grubhub_receipt_one, :grubhub],
      [:grubhub_receipt_two, :grubhub],
      [:grubhub_receipt_three, :grubhub],
      [:grubhub_receipt_four, :grubhub],
      [:caviar_receipt_one, :caviar],
      [:caviar_receipt_two, :caviar],
      [:gmail_autoforwarder_one, :gmail_autoforwarder_confirm],
      [:gmail_autoforwarder_two, :gmail_autoforwarder_confirm]
    ].each do |email|

      describe email[0] do

        it "should return #{email[1]}" do
          @scraper
            .determine_scraper(FactoryGirl.build(:email, email[0]))
            .should eq email[1]
        end

      end

    end

  end

end