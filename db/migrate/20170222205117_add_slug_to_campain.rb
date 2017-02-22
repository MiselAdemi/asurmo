class AddSlugToCampain < ActiveRecord::Migration
  def change
    add_column :campains, :slug, :string
    add_index :campains, :slug
  end
end
