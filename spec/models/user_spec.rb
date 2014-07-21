require 'spec_helper'

describe User do
  
  it 'should send set_mission mailer after creation' do
    MissionMailer.any_instance.expects(:set_mission)
    @user = FactoryGirl.create(:user)
  end

  describe "#reset_mission_statement" do

    before(:each) do
      Delayed::Worker.delay_jobs = false
      @user = FactoryGirl.create(:user, :with_mission)
    end

    it "should change the :mission_statement" do
      @user.reset_mission_statement('Some new mission')
      @user.mission_statement.should == 'Some new mission'
    end

    it "should set the :mission to nil" do
      @user.reset_mission_statement('Some new mission')
      @user.mission.should == nil
    end

    it "should send out the right mailer" do
      Delayed::Worker.delay_jobs = false
      MissionMailer.any_instance.expects(:new_mission).with(@user.email, 'Some new mission')
      @user.reset_mission_statement('Some new mission')
    end

  end

end
