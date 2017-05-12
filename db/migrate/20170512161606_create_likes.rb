class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :post_type

      t.timestamps
    end
  end
end
