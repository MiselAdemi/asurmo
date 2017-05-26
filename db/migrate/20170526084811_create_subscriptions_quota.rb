class CreateSubscriptionsQuota < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions_quota do |t|
      t.string :plan
      t.integer :organizations_quota
      t.integer :campains_quota
      t.integer :events_quota

      t.timestamps
    end
  end
end
