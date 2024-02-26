class Item < ApplicationRecord
  has_many :wishlists
  has_many :planners

  validates :name, presence: true
end
