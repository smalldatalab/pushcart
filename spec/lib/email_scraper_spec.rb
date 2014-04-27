require 'spec_helper'

describe EmailScraper do

  describe "#evaluate_and_process" do

    before(:each) do
      @ie = FactoryGirl.create(:inbound_email)
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

end