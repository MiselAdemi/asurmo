class RenameActivityColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :activities, :to, :to_id
  end
end
