class Room < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, dependent: :destroy
  has_many :bookings
  has_many :ratings
  validates :price, :numericality => { :greater_than => 0 }

  def self.search(search)
    if search
      Room.where('location LIKE ?', "%#{search}%")
    else
      Room.all
    end
  end

  def average_rating
    ratings = []
    if self.ratings.count > 0
      self.ratings.each {|r| ratings << r.stars}
      ratings.inject{ |sum, rating| sum + rating }.to_f / ratings.size
    else
      ratings = 0.0
    end
  end
end
