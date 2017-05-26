class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :subscriptions_quota_id
      t.datetime :created_at

      t.timestamps
    end
  end
end
