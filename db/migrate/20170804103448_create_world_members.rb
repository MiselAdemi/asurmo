class CreateWorldMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :world_members do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :country_code
      t.integer :city_id
      t.string :street
      t.string :zip_code

      t.timestamps
    end
  end
end
