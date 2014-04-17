class Booking < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  after_create :send_booking_confirmation

  def self.room_booked_by_user(room, user)
    Booking.exists?(room_id: room.id, user_id: user.id)
  end

  def self.available(booking)
    this_rooms_bookings = Booking.where(room_id: booking.room_id)
    this_rooms_bookings.each do |b|
      if booking.start_date.between?(b.start_date, b.end_date) || booking.end_date.between?(b.start_date, b.end_date)
        return false
      end
    end
    true
  end

  def send_booking_confirmation
    BookingMailer.booking_confirmation(self).deliver
  end
end
