class AddUserToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_reference :organizations, :user, index: true, foreign_key: true
  end
end
