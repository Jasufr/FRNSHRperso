class PlannersController < ApplicationController
  def index
    @planners = policy_scope(Planner)
    @room = Room.find(params[:room_id])
    @planners = @planners.where(room: @room)
    @wishlists = @room.wishlists
    @planner = Planner.new
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name.pdf", template: "planners/_printing", layout: 'pdf', formats: [:html]
      end
    end
  end

  def create
    @room = Room.find(params[:room_id])
    @planner = Planner.new(planner_params)
    @planner.room = @room
    authorize @planner
    respond_to do |format|
      if @planner.save
        @planners = current_user.planners.where(room: @room)
        html = render_to_string(partial: "planner_card", formats: :html, locals: { planner: @planner })
        colorhtml = render_to_string(partial: "colorswatch", formats: :html, locals: { planner: @planners })
        # create the colorbar as a string using a partial
        format.html { redirect_to room_planners_path(@room) }
        format.json { render json: { html: html, colorswatch: colorhtml, price: @room.planner_items.sum { |item| item.price } } }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @planner.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @planner = Planner.find(params[:id])
    authorize @planner
    @room = @planner.room
    @planner.destroy
    respond_to do |format|
    if @planner.destroy
      @planners = current_user.planners.where(room: @room)
      colorhtml = render_to_string(partial: "colorswatch", formats: :html, locals: { planner: @planners })
      # format.html {redirect_to room_planners_path(@room), status: :see_other}
      format.json { render json: {colorswatch: colorhtml, price: @room.planner_items.sum { |item| item.price } } }
    end
  end
  end

  private

  def planner_params
    params.require(:planner).permit(:frnshr_room_id, :frnshr_item_id)
  end

end
