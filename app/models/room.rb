class Room < ActiveRecord::Base
  belongs_to :user
  has_many :pictures
  has_many :bookings
  has_many :ratings

  def self.search(search)
    if search
      find(:all, :conditions => ['location LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
