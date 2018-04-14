class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :action
      t.integer :trackable_id
      t.string :trackable_type

      t.timestamps null: false
    end
  end
end
