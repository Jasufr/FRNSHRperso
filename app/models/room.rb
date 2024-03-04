class Room < ApplicationRecord
  belongs_to :user
  has_many :wishlists, dependent: :destroy
  has_many :planners, dependent: :destroy
  has_many :planner_items, through: :planners, source: :item
  has_many :wish_items, through: :wishlists, source: :item

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
