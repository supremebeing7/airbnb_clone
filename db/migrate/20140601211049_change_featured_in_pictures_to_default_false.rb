class ChangeFeaturedInPicturesToDefaultFalse < ActiveRecord::Migration
  def change
    change_column :pictures, :featured, :boolean, default: false
  end
end
