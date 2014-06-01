require 'spec_helper'

describe Room do
  it { should have_many :ratings }
  it { should have_many :bookings }
  it { should belong_to :user }
  it { should have_many :pictures }
  it { should validate_numericality_of(:price).is_greater_than(0) }
end
