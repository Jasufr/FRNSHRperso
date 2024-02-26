class Room < ApplicationRecord
  belongs_to :user
  has_many :wishlists
  has_many :planners
  has_many :planner_items, through: :planners, source: :item
  has_many :wish_items, through: :wishlists, source: :item

  validates :room_type, presence: true
  validates :palette, presence: true
  ROOMS = ['kitchen', 'bathroom', 'bedroom', 'living', 'dining', 'garden', 'kids']
  validates :room_type, inclusion: { in: ROOMS }
end
