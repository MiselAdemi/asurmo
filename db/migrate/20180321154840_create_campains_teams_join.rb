class CreateCampainsTeamsJoin < ActiveRecord::Migration[5.1]
  def self.up
    create_table 'campains_teams', :id => false do |t|
      t.column "campain_id", :integer
      t.column "team_id", :integer
    end
  end

  def self.down
    drop_table 'campains_teams'
  end
end
