class AddAvatarToCampains < ActiveRecord::Migration[5.0]
  def change
    add_column :campains, :avatar, :string
  end
end
