class BookingMailer < ActionMailer::Base
  # default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.booking_confirmation.subject
  #
  def booking_confirmation(booking)
    @traveler = User.find(booking.user_id)
    @room = Room.find(booking.room_id)
    @owner = User.find(@room.user_id)

    mail to: [@traveler.email, @owner.email], subject: "Booking Confirmation"
  end
end
