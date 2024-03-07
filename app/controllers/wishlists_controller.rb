class WishlistsController < ApplicationController
  include ColorMatching

  def index
    @wishlist = Wishlist.new
    @wishlists = policy_scope(Wishlist)
    @room = Room.find(params[:room_id])
    @wishlists = @wishlists.where(room: @room)

    user_colors = @room.palette # Assuming user selects an array of colors somehow


    # Assuming user selects an array of colors somehow
    params[:colors].delete("#000001") if params[:colors].present?
    if params[:colors].nil? || params[:colors].empty?
      user_colors = @room.palette
    else
      user_colors = params[:colors]
    end

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
    # if @wishlist.save
    #   redirect_to room_wishlists_path(@room)
    # else
    #   render :new, status: :unprocessable_entity
    # end
    respond_to do |format|
      if @wishlist.save
        @wishlists = current_user.wishlists.where(room: @room)
        # html2 = render_to_string(partial: "shared/status", formats: :html, locals: { wishlist: @wishlist, wishlists: @wishlists })
        counter = @wishlists.count
        html = render_to_string(partial: "shared/wishlistcard", formats: :html, locals: { wishlist: @wishlist, wishlists: @wishlists })
        format.html { redirect_to room_wishlists_path(@room) }
        format.json { render json: { counter: counter, html: html } }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @wishlist.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    authorize @wishlist
    @room = @wishlist.room
    @wishlist.destroy
    # raise
    if params[:origin] == "wishlists"
      redirect_to room_wishlists_path(@room), status: :see_other
    else
      redirect_to room_planners_path(@room), status: :see_other
    end
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:item_id)
  end
end
