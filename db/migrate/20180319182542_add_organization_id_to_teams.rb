class AddOrganizationIdToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :organization_id, :integer
  end
end
