class Planner < ApplicationRecord
  self.table_name = "frnshr_planners"
  belongs_to :room, foreign_key: "frnshr_room_id"
  belongs_to :item, foreign_key: "frnshr_item_id"
end
