class AddFeaturedToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :featured, :boolean
  end
end
