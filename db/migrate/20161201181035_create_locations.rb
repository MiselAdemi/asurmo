class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :country
      t.string :city
      t.string :accentcity
      t.string :region
      t.integer :population
      t.string :latitude
      t.string :longitude

      t.timestamps null: false
    end
  end
end
