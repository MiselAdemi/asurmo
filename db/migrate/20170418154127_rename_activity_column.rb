class RenameActivityColumn < ActiveRecord::Migration
  def change
    rename_column :activities, :to, :to_id
  end
end
