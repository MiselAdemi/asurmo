class AddCampainReferencesToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :campain, index: true, foreign_key: true
  end
end
