class AddFieldsToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :to, :integer
    add_column :activities, :to_type, :string
    add_column :activities, :from_type, :string
  end
end
