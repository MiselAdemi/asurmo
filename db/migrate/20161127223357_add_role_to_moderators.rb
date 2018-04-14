class AddRoleToModerators < ActiveRecord::Migration[5.1]
  def change
    add_column :moderators, :role, :integer
  end
end
