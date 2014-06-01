class RoomsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @pictures = Picture.all
    @available_rooms = []
    @rooms = Room.search(params[:location])
    if params[:start_date] != "" && params[:end_date] != ""
      @rooms.each do |room|
        @booking = Booking.new(room_id: room.id,
                                start_date: params[:start_date],
                                end_date: params[:end_date])
        if Booking.available(@booking)
          @available_rooms << room
        end
      end
    else
      @available_rooms = @rooms
    end
    @available_rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "Thanks for adding a new Room!"
      redirect_to @room
    else
      render new_room_path
    end
  end

  def show
    @room = Room.find(params[:id])
    @rating = Rating.new
    @booking = Booking.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = 'Room Updated'
      redirect_to room_path(@room)
    else
      flash[:notice] = 'Failed to Update'
      redirect_to :back
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @user = @room.user
    @room.destroy
    flash[:notice] = "Room Deleted"
    redirect_to @user
  end

private
  def room_params
    params.require(:room).permit(:location, :price, :user_id, :search)
  end

end
