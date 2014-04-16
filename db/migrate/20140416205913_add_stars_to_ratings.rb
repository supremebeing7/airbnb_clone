class AddStarsToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :stars, :integer
  end
end
