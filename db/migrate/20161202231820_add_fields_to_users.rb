class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :country_code, :string
    add_column :users, :city_id, :integer
    add_column :users, :mobile_phone, :string
    add_column :users, :gender, :integer
    add_column :users, :employee_status, :integer
  end
end
