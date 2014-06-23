class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.integer :stop_id
      t.string :street_on
      t.string :street_cross
      t.float :boardings
      t.float :alightings
      t.float :lat
      t.float :long
      t.integer :route_count
      t.string :route_list
    end
  end
end
