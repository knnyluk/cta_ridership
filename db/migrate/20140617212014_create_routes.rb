class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :number
      t.integer :stop_count
      t.float :total_alightings
      t.float :total_boardings
    end
  end
end
