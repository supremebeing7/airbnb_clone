class Booking < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  # after_create :send_booking_confirmation

  def self.room_booked_by_user(room, user)
    Booking.exists?(room_id: room.id, user_id: user.id)
  end

  def self.available(start_date, end_date, room)
    this_room = Booking.where(room_id: room.id)
    this_room.each do |booking|
      if start_date.between?(booking.start_date, booking.end_date) || end_date.between?(booking.start_date, booking.end_date)
        return false
      end
    end
    true
  end

  def send_booking_confirmation
    BookingMailer.booking_confirmation(self).deliver
  end
end
