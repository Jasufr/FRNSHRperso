class User < ApplicationRecord
  has_many :rooms
  has_many :planners, through: :rooms
  has_many :wishlists, through: :rooms
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
