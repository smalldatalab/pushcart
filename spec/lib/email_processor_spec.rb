require 'spec_helper'

describe EmailProcessor do

  before(:all) do
    Delayed::Worker.delay_jobs = false

    @user  = FactoryGirl.create(:user)
    @email = FactoryGirl.build(:email, to: [{email: "#{@user.endpoint_email}@#{EMAIL_URI}"}])
    @email.to = [{email: @email.to}]
    @email.from = {email: @email.from}
  end

  pending 'should send right mailer if user is not found' do
    @email.stubs(:to).returns([{email: "non-existant-email@#{EMAIL_URI}"}])
    UserMailer.any_instance.expects(:cannot_find_account).with(@email, 'non-existant-email')

    EmailProcessor.new(@email).process
  end

  it 'should save a copy of the email and queue for later scraping' do
    EmailScraper.expects(:new)

    EmailProcessor.new(@email).process
  end

end