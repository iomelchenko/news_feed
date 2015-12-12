class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates_presence_of :password, on: :create

  has_many :news
  has_many :comments
  has_many :ratings
end
