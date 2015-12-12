class News < ActiveRecord::Base
  validates_presence_of :title, :body, :user_id

  belongs_to :user
  has_many   :comments
  has_many   :ratings, as: :target
end
