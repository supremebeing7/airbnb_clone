class Room < ActiveRecord::Base
  belongs_to :user
  has_many :pictures

  def self.search(search)
    if search
      find(:all, :conditions => ['location LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
