require 'spec_helper'

describe Room do
  it { should have_many :ratings }
  it { should have_many :bookings }
end
