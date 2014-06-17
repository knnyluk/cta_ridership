class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :number
    end
  end
end
