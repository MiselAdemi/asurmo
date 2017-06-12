class AddRemovedFieldToOrganizations < ActiveRecord::Migration[5.0]
  def change
  	add_column :organizations, :removed, :boolean, :default => false
  end
end
