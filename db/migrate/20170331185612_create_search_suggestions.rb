class CreateSearchSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :search_suggestions do |t|
      t.string :term
      t.integer :popularity

      t.timestamps null: false
    end
  end
end
