class CreateParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :participants do |t|
      t.integer :campain_id
      t.integer :user_id

      t.timestamps
    end
  end
end
