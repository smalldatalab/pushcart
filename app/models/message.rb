class Message < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :oauth_application

  serialize   :to, Array

end
