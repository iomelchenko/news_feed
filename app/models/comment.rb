class Comment < ActiveRecord::Base
  validates_presence_of :comment, :news_id

  belongs_to :user
  belongs_to :news
  has_many   :ratings, as: :target
end
