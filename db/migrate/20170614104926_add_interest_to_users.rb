class AddInterestToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :interests, :json
  end
end