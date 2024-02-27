class PlannersController < ApplicationController
  def index
    @planners = policy_scope(Planner)
    @room = Room.find(params[:room_id])
    @planners = @planners.where(room: @room)
    @wishlists = @room.wishlists
  end
end
