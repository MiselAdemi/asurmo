class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :organizations, :user_id, :owner_id
  end
end
