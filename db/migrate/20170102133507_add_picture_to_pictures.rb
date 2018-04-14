class AddPictureToPictures < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :picture, :string
  end
end
