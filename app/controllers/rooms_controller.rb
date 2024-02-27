class RoomsController < ApplicationController
  def new
    authorize @room
  end
end
