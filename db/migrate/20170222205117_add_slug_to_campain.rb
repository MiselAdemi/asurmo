class AddSlugToCampain < ActiveRecord::Migration[5.1]
  def change
    add_column :campains, :slug, :string
    add_index :campains, :slug
  end
end
