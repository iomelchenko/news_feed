class Rating < ActiveRecord::Base
  validates_presence_of :rating, :target_id, :target_type
  validates_inclusion_of :rating, in: 1..5
  validates :user_id, uniqueness: {scope: [:target_id, :target_type]}, if: 'user_id.present?'

  belongs_to :target, polymorphic: true
end
