class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :registerable, :confirmable, :timeoutable, :trackable

  has_many :purchases
  has_many :items, through: :purchases
  has_many :household_members, dependent: :destroy
  has_many :messages, dependent: :destroy

  belongs_to :mission

  after_initialize :set_endpoint_email
  after_create     :send_welcome_email
  after_save       :send_onboarding_emails,         if: Proc.new { |u| u.confirmed_at_changed? && u.confirmed_at_was.nil? }
  after_save       :send_pushcart_endpoint_mailer,  if: Proc.new { |u| u.endpoint_email_changed? && !u.confirmed_at_was.nil? }

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

  def send_welcome_email
    UserMailer.delay.welcome(self.id)
  end

  def send_onboarding_emails
    UserMailer.delay.getting_started(self.id) if (household_size == 0 || mission_statement.nil?)
    send_pushcart_endpoint_mailer
  end

  def send_pushcart_endpoint_mailer
    UserMailer.delay.new_pushcart_endpoint_email(self.id)
  end

  def generate_endpoint_email_recommendation
    email_root = /^[^\@]*/.match(email)[0].downcase
    recommendation = email_root.dup
    trailer = 1

    until User.find_by_endpoint_email(recommendation).nil?
      recommendation = "#{email_root}-#{trailer}"
      trailer += 1
    end

    self.endpoint_email = recommendation
  end

private

  def set_endpoint_email
    generate_endpoint_email_recommendation if endpoint_email.blank?
  end

end