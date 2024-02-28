class Room < ApplicationRecord
  belongs_to :user
  has_many :wishlists, dependent: :destroy
  has_many :planners, dependent: :destroy
  has_many :planner_items, through: :planners, source: :item
  has_many :wish_items, through: :wishlists, source: :item

  validates :room_type, presence: true
  validates :palette, presence: true
  ROOMS = ['Kitchen', 'Bathroom', 'Bedroom', 'Living', 'Dining', 'Garden', 'Kids']
  validates :room_type, inclusion: { in: ROOMS }
end
