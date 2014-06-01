require 'spec_helper'

describe Booking do
  it { should belong_to :room }
  it { should belong_to :user }

  before :each do
    @owner = create :owner
    @traveler = create :traveler
    @room = create(:room, user_id: @owner.id)
  end

  context '#room_booked_by_user' do
    it 'tells whether a room has been booked by a user' do
      booking = Booking.create(user_id: @traveler.id, room_id: @room.id)
      Booking.room_booked_by_user(@room, @traveler).should eq true
    end
  end

  context '#available' do
    it 'checks if there is overlap in booking date sets' do
      booking0 = Booking.create(room_id: @room.id, user_id: @traveler.id, start_date: "01-01-14",
                               end_date: "05-01-14")
      booking1 = Booking.create(room_id: @room.id, user_id: @traveler.id, start_date: "24-01-14",
                             end_date: "26-01-14")
      booking2 = Booking.new(room_id: @room.id, user_id: @traveler.id, start_date: "04-01-14",
                               end_date: "09-01-14")
      Booking.available(booking2).should eq false
      booking3 = Booking.new(room_id: @room.id, user_id: @traveler.id, start_date: "14-01-14",
                             end_date: "19-01-14")
      Booking.available(booking3).should eq true
    end
  end
  context "#send_booking_confirmation" do
    it "sends booking confirmation after booking created" do
      booking = Booking.new(room_id: @room.id, user_id: @traveler.id, start_date: "01-01-14",
                               end_date: "05-01-14")
      BookingMailer.should_receive( :booking_confirmation ).and_call_original
      booking.save
    end
  end
end
