class User < ApplicationRecord
  self.table_name = "frnshr_users"
  has_many :rooms, foreign_key: "frnshr_user_id"
  has_many :planners, foreign_key: "frnshr_user_id", through: :rooms
  has_many :wishlists, foreign_key: "frnshr_user_id", through: :rooms
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
