class News < ActiveRecord::Base
  before_create :initiate_state

  validates_presence_of :title, :body, :user_id

  belongs_to :user
  has_many   :comments
  has_many   :ratings, as: :target

  scope :published,  -> { where(state: 'published') }

  private

  def initiate_state
    self.state = 'pending approval'
  end
end
