class AddUserToInterests < ActiveRecord::Migration
  def change
    add_reference :interests, :user, index: true, foreign_key: true
  end
end
