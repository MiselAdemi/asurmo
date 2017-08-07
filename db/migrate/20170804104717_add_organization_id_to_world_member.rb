class AddOrganizationIdToWorldMember < ActiveRecord::Migration[5.0]
  def change
    add_column :world_members, :organization_id, :integer
  end
end
