class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :organizations_quota
      t.integer :campains_quota
      t.integer :events_quota
    end
  end
end
