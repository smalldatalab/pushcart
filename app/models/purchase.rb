class Purchase < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  belongs_to  :user
  has_many    :items, dependent: :destroy
  validates_presence_of :items, :user

  # before_create :encrypt_attributes, if: :use_privacy_hashing?

private

  def use_privacy_hashing?
    USE_PRIVACY_HASHING
  end

  def encrypt_attributes
    aes = OpenSSL::Cipher.new('AES-256-CBC')
    aes.encrypt
    aes.key = SECRET_KEY
    self.raw_message = Base64.encode64(aes.update(raw_message) + aes.final).encode('UTF-8')
  end

end
