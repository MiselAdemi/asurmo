class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.text :body
      t.integer :author_id
      t.string :author_type
      t.belongs_to :statusable, polymorphic: true
      
      t.timestamps
    end
    
    add_index :statuses, [:statusable_id, :statusable_type]
  end
end
