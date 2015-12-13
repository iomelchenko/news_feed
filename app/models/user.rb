class User < ActiveRecord::Base
  before_save :ensure_api_key, :encrypted_password
  attr_accessor :password

  validates :username, presence: true, uniqueness: true
  validates_presence_of :password, on: :create

  has_many :news
  has_many :comments
  has_many :ratings

  private

  def encrypted_password
    if password.present?
      self.encrypted_password = Digest::SHA1.hexdigest(password)
    end
  end

  def self.authenticated(username, password)
    user = find_by_username(username)
    if user && user[:encrypted_password] == Digest::SHA1.hexdigest(password)
      user
    else
      nil
    end
  end

  def ensure_api_key
    self.api_key = generate_api_key
    self.api_key_expires_at = Time.now + 2.hours
  end

  def generate_api_key
    loop do
      key = SecureRandom.uuid.gsub(/\-/,'')
      break key unless User.where(api_key: key).first
    end
  end
end
