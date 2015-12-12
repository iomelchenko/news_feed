class User < ActiveRecord::Base
  before_save :encrypted_password
  attr_accessor :password

  validates :username, presence: true, uniqueness: true
  validates_presence_of :password, on: :create

  has_many :news
  has_many :comments
  has_many :ratings

  private

  def encrypted_password
    self.encrypted_password = Digest::SHA1.hexdigest(password)
  end
end
