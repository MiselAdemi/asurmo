class AddOrganizationReferencesToCampains < ActiveRecord::Migration[5.1]
  def change
    add_reference :campains, :organization, index: true, foreign_key: true
  end
end
