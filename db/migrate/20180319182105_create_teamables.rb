class CreateTeamables < ActiveRecord::Migration[5.1]
  def change
    create_table :teamables do |t|
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
  end
end
