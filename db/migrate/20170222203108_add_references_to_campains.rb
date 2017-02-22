class AddReferencesToCampains < ActiveRecord::Migration
  def change
    add_reference :campains, :user, index: true, foreign_key: true
  end
end
