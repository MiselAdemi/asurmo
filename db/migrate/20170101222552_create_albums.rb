class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title

      t.timestamps null: false
    end
  end
end
