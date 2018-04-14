class RenameOldMemberTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :moderators, :members
  end
end
