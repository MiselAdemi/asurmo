class AddCoverImageToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :cover_image, :string
  end
end
