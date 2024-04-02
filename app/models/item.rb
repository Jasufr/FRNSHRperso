class Item < ApplicationRecord
  self.table_name = "frnshr_items"
  has_many :wishlists, foreign_key: "frnshr_item_id", dependent: :destroy
  has_many :planners, foreign_key: "frnshr_item_id", dependent: :destroy
  before_save :set_default_x, if: :no_x_value?
  before_save :set_default_y, if: :no_y_value?
  before_save :set_default_z, if: :no_z_value?

  validates :name, presence: true
  validates :price, presence: true
  validates :photo, presence: true
  validates :color, presence: true
  validates :shop_url, presence: true
  validates :furniture_type, presence: :true

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true }
    }

  ROOM_ITEMS = { "kitchen" => ["chair", "table", "stool", "cabinet", "counter"], "bedroom" => ["bed", "cushion", "chair", "cabinet", "bookcase", "rug"], "bathroom" => [], "living" => ["curtain", "curtains", "sofa", "cushion", "chair", "table", "cabinet", "bookcase", "rug"], "dining" => ["chair", "table", "cabinet", "counter"], "garden" => [], "kids" => [] }

  def surface_area
    x_dimension*y_dimension + y_dimension*z_dimension + x_dimension*z_dimension
  end

  def add_color
    self.color = ColorAnalyze.new(self.photo).call
  end

  private

  def no_x_value?
    self.x_dimension.nil?
  end

  def no_y_value?
    self.y_dimension.nil?
  end

  def no_z_value?
    self.z_dimension.nil?
  end

  def set_default_x
    case self.furniture_type
      when "cushion" then self.x_dimension = 50
      when "sofa" then self.x_dimension = 150
      when "chair" then self.x_dimension = 70
      when "table" then self.x_dimension = 180
      when "stool" then self.x_dimension = 40
      when "cabinet" then self.x_dimension = 160
      when "counter" then self.x_dimension = 100
      when "bed" then self.x_dimension = 150
      when "bookcase" then self.x_dimension = 75
      when "rug" then self.x_dimension = 230
      when "curtain" then self.x_dimension = 250
      when "curtains" then self.x_dimension = 250
    end
    save
  end

  def set_default_y
    case self.furniture_type
      when "cushion" then self.y_dimension = 50
      when "sofa" then self.y_dimension = 70
      when "chair" then self.y_dimension = 80
      when "table" then self.y_dimension = 80
      when "stool" then self.y_dimension = 45
      when "cabinet" then self.y_dimension = 185
      when "counter" then self.y_dimension = 15
      when "bed" then self.y_dimension = 90
      when "bookcase" then self.y_dimension = 150
      when "rug" then self.y_dimension = 160
      when "curtain" then self.y_dimension = 210
      when "curtains" then self.y_dimension = 210
    end
    save
  end

  def set_default_z
    case self.furniture_type
      when "cushion" then self.z_dimension = 15
      when "sofa" then self.z_dimension = 70
      when "chair" then self.z_dimension = 80
      when "table" then self.z_dimension = 90
      when "stool" then self.z_dimension = 50
      when "cabinet" then self.z_dimension = 30
      when "counter" then self.z_dimension = 50
      when "bed" then self.z_dimension = 200
      when "bookcase" then self.z_dimension = 40
      when "rug" then self.z_dimension = 5
      when "curtain" then self.z_dimension = 5
      when "curtains" then self.z_dimension = 5
    end
    save
  end
end
