require 'spec_helper'

describe User do

  describe 'onboarding mailers' do  
    # it 'should send set_mission mailer after creation' do
    #   MissionMailer.any_instance.expects(:set_mission)
    #   @user = FactoryGirl.create(:user)
    # end
  end

  describe "#reset_mission_statement" do

    # before(:each) do
    #   Delayed::Worker.delay_jobs = false
    #   @user = FactoryGirl.create(:user, :with_mission)
    # end

    # it "should change the :mission_statement" do
    #   @user.reset_mission_statement('Some new mission')
    #   @user.mission_statement.should == 'Some new mission'
    # end

    # it "should set the :mission to nil" do
    #   @user.reset_mission_statement('Some new mission')
    #   @user.mission.should == nil
    # end

    # it "should send out the right mailer" do
    #   Delayed::Worker.delay_jobs = false
    #   MissionMailer.any_instance.expects(:new_mission).with(@user.email, 'Some new mission')
    #   @user.reset_mission_statement('Some new mission')
    # end

  end

  describe '#generate_endpoint_email_recommendation' do

    it 'should return user root e-mail address' do
      user = User.new(email: 'otto@vonbismarck.de')
      user.generate_endpoint_email_recommendation.should == 'otto'
    end

    it 'if endpoint email is already taken, should return a modified one' do
      FactoryGirl.create(:user, endpoint_email: 'otto')
      new_user_1 = User.create(email: 'otto@vonbismarck.de')
      new_user_1.endpoint_email.should == 'otto-1'
      new_user_2 = User.create(email: 'otto@dix.com')
      new_user_2.endpoint_email.should == 'otto-2'
    end

  end

end
