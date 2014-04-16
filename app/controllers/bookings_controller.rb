class BookingsController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @user = User.find(params[:user_id])
    Booking.create(user_id: @user.id, room_id: @room.id)
    redirect_to room_path(@room), notice: "Booked!"
  end
end
