class DropInterestsTable < ActiveRecord::Migration[5.0]
  def change
  	drop_table :interests_lists
  end
end
