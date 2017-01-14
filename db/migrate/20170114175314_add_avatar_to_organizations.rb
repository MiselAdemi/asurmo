class AddAvatarToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :avatar, :string
    add_column :organizations, :description, :string
  end
end
