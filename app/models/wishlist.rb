class Wishlist < ApplicationRecord
  self.table_name = "frnshr_wishlists"
  belongs_to :room, foreign_key: "frnshr_room_id"
  belongs_to :item, foreign_key: "frnshr_item_id"
  has_one :user, foreign_key: "frnshr_wishlist_id", through: :room
end
