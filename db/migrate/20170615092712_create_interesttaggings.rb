class CreateInteresttaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :interesttaggings do |t|
      t.belongs_to :interest, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
