class AddRoleToModerators < ActiveRecord::Migration
  def change
    add_column :moderators, :role, :integer
  end
end
