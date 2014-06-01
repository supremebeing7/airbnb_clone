class BookingMailer < ActionMailer::Base
  default from: "hello@wherebnb.com"

  def booking_confirmation(booking)
    @traveler = User.find(booking.user_id)
    @room = Room.find(booking.room_id)
    @owner = User.find(@room.user_id)

    mail to: [@traveler.email, @owner.email], subject: "Booking Confirmation"
  end
end
