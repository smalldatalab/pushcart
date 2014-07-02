class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :registerable, :confirmable, :timeoutable, :trackable

  has_many :purchases
  has_many :items, through: :purchases
  has_many :household_members, dependent: :destroy
  has_many :messages, dependent: :destroy

  belongs_to :mission

  after_initialize :set_endpoint_email
  # after_create     :send_set_mission_request

  validates_presence_of   :email, :endpoint_email
  validates_uniqueness_of :email, :endpoint_email

  accepts_nested_attributes_for :household_members

  def endpoint_email_with_uri
    "#{endpoint_email}@#{EMAIL_URI}"
  end

  def household_size
    household_members.count
  end

  def login_token_expired?
    login_token_expires_at.blank? || Time.now > login_token_expires_at
  end

  def return_or_set_login_token
    if authentication_token.nil? || authentication_token_expires_at.blank? || Time.now > authentication_token_expires_at
      self.authentication_token = nil
      save
      authentication_token
    else
      authentication_token
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

end

# User.create(email: "michael@aqua.io")