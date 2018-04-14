class CreateCampains < ActiveRecord::Migration[5.1]
  def change
    create_table :campains do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
