class Item < ApplicationRecord
  has_many :wishlists
  has_many :planners
end
