class BookingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @booking = Booking.create(bookings_params)
    redirect_to room_path(@booking.room), notice: "Booked! An email confirmation has been sent to you and the owner."
  end

  private

  def bookings_params
    params.require(:booking).permit(:start_date, :end_date, :room_id, :user_id)
  end
end
