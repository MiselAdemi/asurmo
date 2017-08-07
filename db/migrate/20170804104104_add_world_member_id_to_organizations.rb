class AddWorldMemberIdToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :world_member_id, :integer
  end
end
