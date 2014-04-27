class InboundEmail < ActiveRecord::Base
  belongs_to  :user

  serialize   :to, Array

end
