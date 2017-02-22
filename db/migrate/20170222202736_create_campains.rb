class CreateCampains < ActiveRecord::Migration
  def change
    create_table :campains do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
