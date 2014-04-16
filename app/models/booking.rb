class Booking < ActiveRecord::Base
  after_create :send_booking_confirmation

  def send_booking_confirmation
    BookingMailer.booking_confirmation(self).deliver
  end
end
