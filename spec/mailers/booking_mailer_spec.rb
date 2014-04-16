require "spec_helper"

describe BookingMailer do
  describe "booking_confirmation" do
    let(:mail) { BookingMailer.booking_confirmation }

    it "renders the headers" do
      mail.subject.should eq("Booking confirmation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
