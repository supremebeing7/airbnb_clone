require "spec_helper"

describe BookingMailer do
  describe "booking_confirmation" do
    let(:mail) do
      @owner = create(:owner)
      @traveler = create(:traveler)
      @room = create(:room, user_id: @owner.id)
      @booking = build(:booking, user_id: @traveler.id, room_id: @room.id)
      BookingMailer.booking_confirmation(@booking)
    end

    it "renders the headers" do
      mail.subject.should eq("Booking Confirmation")
      mail.to.should eq([@traveler.email, @owner.email])
      mail.from.should eq(["hello@wherebnb.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("has booked this room")
    end
  end

end
