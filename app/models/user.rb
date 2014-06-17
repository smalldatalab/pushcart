class User < ActiveRecord::Base
  devise :registerable, :confirmable, :timeoutable, :trackable

  has_many :purchases
  has_many :items, through: :purchases
  belongs_to :mission

  after_initialize :set_endpoint_email, :set_login_token
  after_create     :send_set_mission_request

  validates_presence_of   :email, :endpoint_email, :household_size
  validates_uniqueness_of :email, :endpoint_email, :login_token

  def endpoint_email_with_uri
    "#{endpoint_email}@#{EMAIL_URI}"
  end

  def login_token_expired?
    login_token_expires_at.blank? || Time.now > login_token_expires_at
  end

  def return_or_set_login_token
    if login_token_expired?
      refresh_login_token
    else
      login_token
    end
  end

  def reset_mission_statement(statement)
    self.mission_statement = statement
    self.mission = nil
    MissionMailer.delay.new_mission(email, mission_statement)
    save
  end

  def send_set_mission_request
    MissionMailer.delay.set_mission(self.id)
  end

private

  def generate_random_endpoint_email
    self.endpoint_email = "#{::Bazaar.super_object.parameterize}-#{::Bazaar.super_object.parameterize}"
  end

  def set_endpoint_email
    generate_random_endpoint_email if endpoint_email.blank?
  end

  def set_login_token
    self.login_token = SecureRandom.urlsafe_base64(20) if login_token.blank?
  end

  def refresh_login_token
    self.login_token            = SecureRandom.urlsafe_base64(20)
    self.login_token_expires_at = DateTime.now + 8.hours
    save
    return login_token
  end

end

# User.create(email: "michael@aqua.io")