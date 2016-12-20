class ChangeGanderIntegerToString < ActiveRecord::Migration
  def self.up
    change_column :users, :gender, :string
  end

  def self.down
    change_column :users, :gender, :integer
  end
end
