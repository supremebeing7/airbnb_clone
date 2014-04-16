require 'spec_helper'

describe User do
  it { should have_many :rooms }
  it { should have_many :bookings }
  it { should have_many :ratings }
end
