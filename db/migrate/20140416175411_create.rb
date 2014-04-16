class Create < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :room
      t.belongs_to :user

      t.timestamps
    end
  end
end
