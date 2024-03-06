class Item < ApplicationRecord
  has_many :wishlists, dependent: :destroy
  has_many :planners, dependent: :destroy

  before_save :set_default_x, if: :no_x_value?
  before_save :set_default_y, if: :no_y_value?
  before_save :set_default_z, if: :no_z_value?


  validates :name, presence: true
  validates :price, presence: true
  validates :photo, presence: true
  validates :color, presence: true
  # validates :shop_name, presence: true
  validates :shop_url, presence: true
  # validates :dimensions, presence: true?
  # validates :shop_item_id, presence: true?
  validates :furniture_type, presence: :true
  # validates :furniture_type, inclusion: { in: ["curtain", "curtains", "cushion","sofa","chair","cabinet","bookcase","counter","table","stool","bed","bookcase","rug"] }

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
      when "cushion" then 50
      when "sofa" then 150
      when "chair" then 70
      when "table" then 180
      when "stool" then 40
      when "cabinet" then 160
      when "counter" then 100
      when "bed" then 150
      when "bookcase" then 75
      when "rug" then 230
      when "curtain" then 250
      when "curtains" then 250
    end
  end

  def set_default_y
    case self.furniture_type
      when "cushion" then 50
      when "sofa" then 70
      when "chair" then 80
      when "table" then 80
      when "stool" then 45
      when "cabinet" then 185
      when "counter" then 15
      when "bed" then 90
      when "bookcase" then 150
      when "rug" then 160
      when "curtain" then 210
      when "curtains" then 210
    end
  end

  def set_default_z
    case self.furniture_type
      when "cushion" then 15
      when "sofa" then 70
      when "chair" then 80
      when "table" then 90
      when "stool" then 50
      when "cabinet" then 30
      when "counter" then 50
      when "bed" then 200
      when "bookcase" then 40
      when "rug" then 5
      when "curtain" then 5
      when "curtains" then 5
    end
  end

end
