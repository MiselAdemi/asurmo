class AddReferencesToCampains < ActiveRecord::Migration[5.1]
  def change
    add_reference :campains, :user, index: true, foreign_key: true
  end
end
