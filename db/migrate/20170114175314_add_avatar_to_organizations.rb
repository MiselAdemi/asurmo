class AddAvatarToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :avatar, :string
    add_column :organizations, :description, :string
  end
end
