require 'spec_helper'

describe GmailAutoforwarder do

  [
    [:gmail_autoforwarder_one, 'https://isolated.mail.google.com/mail/vf-%5BANGjdJ_7e6l_iXqh-Od7cE9_3tLwPN46Hb87yeycJJ6VOBhIA1HLXzxabVjCiot1Tzer4SzkTHwsx_GvyzaLzS_7I5ocGKpq3N3pDhnngiFhbro_2WI1HXr_P-eZ1YM%5D-5XUIPpo9LXBlzoYovuKqWeRecWo'],
    [:gmail_autoforwarder_two, 'https://isolated.mail.google.com/mail/vf-%5BANGjdJ8nMcM1ScbOOeNkoU4P7G6dZmilRLYihKbgAOE4lIg2jO73PadCmmLyPETZ4EkPXZjqMrAajVq0YuVW3tKMcXcjmISxhtiO0-OPxUSe0wKrFF6mfElzEMjeRsc%5D-DQZc5ZIGkRj32mNs7bGOuGPMuwY']
  ].each do |autoforwarder|

    describe autoforwarder[0] do

      before(:all) do
        @processor = GmailAutoforwarder.new FactoryGirl.build(:email, autoforwarder[0])
      end

      it "should return the right link" do
        @processor.get_link.should eq autoforwarder[1]
      end

    end

  end

end