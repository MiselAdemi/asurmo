class AddOrganizationReferencesToCampains < ActiveRecord::Migration
  def change
    add_reference :campains, :organization, index: true, foreign_key: true
  end
end
