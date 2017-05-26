class AddSubsciptionQuotaToUsers < ActiveRecord::Migration[5.0]
  def self.up
    create_table 'users_subscriptions', :id => false do |t|
      t.column 'user_id', :integer
      t.column 'subscriptions_quota_id', :integer
    end
  end

  def self.down
    drop_table 'users_subscriptions'
  end
end
