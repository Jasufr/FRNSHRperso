class WishlistsController < ApplicationController
  include ColorMatching

  def index
    @wishlist = Wishlist.new
    @wishlists = policy_scope(Wishlist)
    @room = Room.find(params[:room_id])
    @wishlists = @wishlists.where(room: @room)
    user_colors = @room.palette # Assuming user selects an array of colors somehow
    @closest_images = closest_matching_images(user_colors)

    # color_range = generate_analogous_colors(@room.palette)

    @items = @closest_images

    # To do: turn this one into Items that matches the room
    if params[:query].present?
      # To do: add also Items that matches the room
      @items = @items.search_by_name(params[:query])
    end
    if params[:room_type].present?
      room_type = params[:room_type]
      @items = Item.where(color: @room.palette, furniture_type: Item::ROOM_ITEMS[room_type])
    end
    # if params[:furniture_type].present?
    #   @items = @items.where(furniture_type: params[:furniture_type])
    # end
    if params[:price_range].present?
      sql_subquery = "price >= ? AND price <= ?"
      @items = @items.where(sql_subquery, params[:price_range].split(",")[0].to_i, params[:price_range].split("-")[1].to_i)
    end
    if params[:width].present? && params[:width] != "-1"
      sql_subquery = "x_dimension >= ? AND x_dimension <= ?"
      @items = @items.where(sql_subquery, (params[:width].to_i - 20), (params[:width].to_i + 20))
    end

    if params[:height].present? && params[:height] != "-1"
      sql_subquery = "y_dimension >= ? AND y_dimension <= ?"
      @items = @items.where(sql_subquery, (params[:height].to_i - 20), (params[:height].to_i + 20))
    end
    if params[:depth].present? && params[:depth] != "-1"
      sql_subquery = "z_dimension >= ? AND z_dimension <= ?"
      @items = @items.where(sql_subquery, (params[:depth].to_i - 20), (params[:depth].to_i + 20))
    end
    # if params[:none].present?
    #   @items = Item.where(color: @room.palette, furniture_type: Item::ROOM_ITEMS[@room.room_type])
    # end
  end

  def create
    @wishlist = Wishlist.new(wishlist_params)
    authorize @wishlist
    @room = Room.find(params[:room_id])
    @wishlist.room = @room
    if @wishlist.save
      redirect_to room_wishlists_path(@room)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    authorize @wishlist
    @room = @wishlist.room
    @wishlist.destroy
    redirect_to room_wishlists_path(@room), status: :see_other
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:item_id)
  end
end
