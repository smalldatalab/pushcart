class ClientApp < Doorkeeper::Application
  validates_presence_of   :uid, :secret
  validates_uniqueness_of :uid
end