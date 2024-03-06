class WishlistsController < ApplicationController
  include ColorMatching

  def index
    @wishlist = Wishlist.new
    @wishlists = policy_scope(Wishlist)
    @room = Room.find(params[:room_id])
    @wishlists = @wishlists.where(room: @room)
    user_colors = @room.palette # Assuming user selects an array of colors somehow


    # color_range = generate_analogous_colors(@room.palette)

    @items = Item.all

    # To do: turn this one into Items that matches the room
    if params[:query].present?
      # To do: add also Items that matches the room
      @items = @items.select { |item| item.name.downcase.include?(params[:query].downcase) || item.furniture_type.downcase.include?(params[:query].downcase)}
    end
    # if params[:room_type].present?
    #   room_type = params[:room_type]
    #   @items = Item.where(color: @room.palette, furniture_type: Item::ROOM_ITEMS[room_type])
    # end
    # # if params[:furniture_type].present?
    # #   @items = @items.where(furniture_type: params[:furniture_type])
    # # end
    # if params[:price_range].present?
    #   sql_subquery = "price >= ? AND price <= ?"
    #   @items = @items.where(sql_subquery, params[:price_range].split(",")[0].to_i, params[:price_range].split("-")[1].to_i)
    # end
    if params[:width].present? && params[:width] != "-1"
      @items = @items.select{|item| item.x_dimension <= params[:width].to_i}
    end

    if params[:height].present? && params[:height] != "-1"
      @items = @items.select{|item| item.y_dimension <= params[:height].to_i}
    end

    if params[:depth].present? && params[:depth] != "-1"
      @items = @items.select{|item| item.z_dimension <= params[:depth].to_i}
    end

    if params[:sort].present? && params[:sort] == 'asc'
      @items = @items.sort_by(&:price)
    elsif params[:sort].present? && params[:sort] == 'desc'
      @items = @items.sort_by(&:price).reverse
    end

    @items = closest_matching_images(user_colors, @items)

    # if params[:none].present?
    #   @items = Item.where(color: @room.palette, furniture_type: Item::ROOM_ITEMS[@room.room_type])
    # end
    #@items = Item.all
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
