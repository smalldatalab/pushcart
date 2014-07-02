class ClientApp < Doorkeeper::Application
  has_many :messages

  after_initialize  :init

  validates_presence_of   :uid, :endpoint_email, :secret
  validates_uniqueness_of :uid, :endpoint_email

private

  def init
    self.endpoint_email = uid if endpoint_email.nil?
  end

end