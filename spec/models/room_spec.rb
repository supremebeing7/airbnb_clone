require 'spec_helper'

describe Room do
  it { should have_many :ratings }
  it { should have_many :bookings }
  it { should belong_to :user }
  it { should have_many :pictures }
  it { should validate_numericality_of(:price).is_greater_than(0) }

  before :each do
    @owner = create(:owner)
    @traveler = create(:traveler)
    @room1 = create(:room, user_id: @owner.id)
  end

  context ".search" do
    it "searches all rooms" do
      @room2 = Room.create(location: Faker::Address.city, price: "100")
      @room3 = Room.create(location: Faker::Address.city, price: "122")
      @room4 = Room.create(location: Faker::Address.city, price: "153")
    end
  end

  context "#average_rating" do
    it "returns the average rating of a room" do
      @room1.ratings.create(stars: 3, review: "Mediocre at best, phenomenal at worst")
      @room1.ratings.create(stars: 4, review: "Mediocre at best, phenomenal at worst")
      @room1.ratings.create(stars: 5, review: "Mediocre at best, phenomenal at worst")
      @room1.ratings.create(stars: 2, review: "Mediocre at best, phenomenal at worst")
      @room1.average_rating.should eq 3.5
    end
  end
end
