class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :room_id
      t.attachment :image
      t.string :caption

      t.timestamps
    end
  end
end
