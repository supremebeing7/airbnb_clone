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
end
