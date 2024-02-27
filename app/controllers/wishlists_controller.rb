class WishlistsController < ApplicationController

def index
  @wishlists = policy_scope(wishlist)
  @room = Room.find(params[:room_id])
  @wishlists = @wishlists.where(room: @room)
end

def create
  @wishlist = Wishlist.new
end

def destroy
  @wishlist = Wishlist.find(params[:id])
  @wishlist.destroy
end

end
