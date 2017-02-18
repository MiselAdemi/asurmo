class RenameOldMemberTable < ActiveRecord::Migration
  def change
    rename_table :moderators, :members
  end
end
