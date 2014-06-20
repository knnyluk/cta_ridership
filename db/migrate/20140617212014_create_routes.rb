class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :number
      t.integer :stop_count 
    end
  end
end
