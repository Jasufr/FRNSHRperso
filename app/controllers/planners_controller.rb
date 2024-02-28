class PlannersController < ApplicationController
  def index
    @planners = policy_scope(Planner)
    @room = Room.find(params[:room_id])
    @planners = @planners.where(room: @room)
    @wishlists = @room.wishlists
    @planner = Planner.new
  end

  def create
    @room = Room.find(params[:room_id])
    @planner = Planner.new(planner_params)
    @planner.room = @room
    authorize @planner
    if @planner.save
      redirect_to room_planners_path(@room)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @planner = Planner.find(params[:id])
    authorize @planner
    @room = @planner.room
    @planner.destroy
    redirect_to room_planners_path(@room), status: :see_other
  end

  private

  def planner_params
    params.require(:planner).permit(:room_id, :item_id)
  end
end
