class AddFieldsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :start_date, :datetime
    add_column :events, :end_date, :datetime
    add_column :events, :description, :string
  end
end
