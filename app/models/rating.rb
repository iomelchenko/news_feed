class Rating < ActiveRecord::Base
  validates_presence_of :rating, :target_id, :target_type

  belongs_to :target, polymorphic: true
end
