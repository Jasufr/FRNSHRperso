class Item < ApplicationRecord
  has_many :wishlists
  has_many :planners

  validates :name, presence: true
  # validates :type, presence: true
  validates :price, presence: true
  validates :photo, presence: true
  validates :color, presence: true
  # validates :shop_name, presence: true
  validates :shop_url, presence: true
  # validates :dimensions, presence: true?
  # validates :shop_item_id, presence: true?

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true }
    }

  ROOM_ITEMS = { "kitchen" => ["chair", "table", "stool", "cabinet", "counter"], "bedroom" => ["bed", "cushion", "chair", "cabinet", "bookcase", "rug"], "bathroom" => [], "living" => ["sofa", "cushion", "chair", "table", "cabinet", "bookcase", "rug"], "dining" => ["chair", "table", "cabinet", "counter"], "garden" => [], "kids" => [] }

  def surface_area
    x_dimension*y_dimension + y_dimension*z_dimension + x_dimension*z_dimension
  end
end
