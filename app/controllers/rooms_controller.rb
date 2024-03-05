class RoomsController < ApplicationController
  def index
    @rooms = policy_scope(Room)
  end

  def show
    @room = Room.find(params[:id])
    authorize @room
  end

  def new
    @room = Room.new
    authorize @room
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user
    authorize @room
    if @room.save
      redirect_to room_wishlists_path(@room)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @room = Room.find(params[:id])
    authorize @room
    @room.destroy
    redirect_to rooms_path, status: :see_other
  end

  private

  def room_params
    params.require(:room).permit(:room_type, palette: [])
  end
end
