require 'spec_helper'

describe User do

  describe 'onboarding mailers' do  
    # it 'should send set_mission mailer after creation' do
    #   MissionMailer.any_instance.expects(:set_mission)
    #   @user = FactoryGirl.create(:user)
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
