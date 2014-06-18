class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.string :street_on
      t.string :street_cross
      t.decimal :boardings
      t.decimal :alightings

      t.timestamps
    end
  end
end
