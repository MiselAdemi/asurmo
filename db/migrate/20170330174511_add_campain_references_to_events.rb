class AddCampainReferencesToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :campain, index: true, foreign_key: true
  end
end
