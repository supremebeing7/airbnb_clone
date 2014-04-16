class Booking < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  # after_create :send_booking_confirmation

  def self.room_booked_by_user(room, user)
    Booking.exists?(room_id: room.id, user_id: user.id)
  end

  def send_booking_confirmation
    BookingMailer.booking_confirmation(self).deliver
  end
end
