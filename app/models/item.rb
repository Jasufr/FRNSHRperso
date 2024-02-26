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
end
