class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|

      t.belongs_to :user
      t.string :location
      t.decimal :price

      t.timestamps
    end
  end
end
