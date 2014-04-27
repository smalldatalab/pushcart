require 'spec_helper'

describe EmailProcessor do

  before(:all) do
    @user  = FactoryGirl.create(:user)
  end

  before(:each) do
    @email = FactoryGirl.build(:email, to: ["#{@user.endpoint_email}@#{EMAIL_URI}"])
  end

  it "should send right mailer if user is not found" do
    @email.stubs(:to).returns(["non-existant-email@#{EMAIL_URI}"])
    UserMailer.any_instance.expects(:cannot_find_account).with(@email)

    EmailProcessor.process(@email)
  end

  it "should save a copy of the email and queue for later scraping" do
    EmailScraper.expects(:new)

    EmailProcessor.process(@email)
  end

end