require 'spec_helper'

describe Booking do
  context '#room_booked_by_user' do
    it 'tells whether a room has been booked by a user' do
      user = FactoryGirl.create :user
      room = FactoryGirl.create :room
      booking = Booking.create(user_id: user.id, room_id: room.id)
      Booking.room_booked_by_user(room, user).should eq true
    end
  end

  context '#available' do
    it 'checks if there is overlap in booking date sets' do
      room = FactoryGirl.create :room
      booking0 = Booking.create(room_id: room.id, start_date: "01-01-14",
                               end_date: "05-01-14")
      booking1 = Booking.create(room_id: room.id, start_date: "24-01-14",
                             end_date: "26-01-14")
      booking2 = Booking.new(room_id: room.id, start_date: "04-01-14",
                               end_date: "09-01-14")
      Booking.available(booking2).should eq false
      booking3 = Booking.new(room_id: room.id, start_date: "14-01-14",
                             end_date: "19-01-14")
      Booking.available(booking3).should eq true
    end
  end
end
