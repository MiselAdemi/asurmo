class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :dob, :string
    add_column :users, :street, :string
    add_column :users, :zip_code, :string
    add_column :users, :activity_status, :string
    add_column :users, :qualification, :string
  end
end
