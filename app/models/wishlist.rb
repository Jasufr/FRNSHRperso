class Wishlist < ApplicationRecord
  belongs_to :room
  belongs_to :item
  has_one :user, through: :room
end
