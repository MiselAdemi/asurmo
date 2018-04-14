class AddAvatarToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :avatar, :string
  end
end
