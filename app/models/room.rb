class Room < ApplicationRecord
  self.table_name = "frnshr_rooms"
  belongs_to :user, foreign_key: "frnshr_user_id"
  has_many :wishlists, foreign_key: "frnshr_room_id", dependent: :destroy
  has_many :planners, foreign_key: "frnshr_room_id", dependent: :destroy
  has_many :planner_items, foreign_key: "frnshr_room_id", through: :planners, source: :item
  has_many :wish_items, foreign_key: "frnshr_room_id", through: :wishlists, source: :item

  validates :room_type, presence: true
  validates :palette, presence: true
  ROOMS = ['kitchen', 'bathroom', 'bedroom', 'living', 'dining', 'garden', 'kids']
  validates :room_type, inclusion: { in: ROOMS }

  def total_area
    planner_items.sum { |item| item.surface_area   }
  end


  def area_by_colors
    planners.joins(:item).group('planners.id', 'items.color').each_with_object({}) do |planner, result|
      color = planner.item.color
      surface_area = planner.item.surface_area
      result[color] ||= 0
      result[color] += surface_area
    end
  end

end
