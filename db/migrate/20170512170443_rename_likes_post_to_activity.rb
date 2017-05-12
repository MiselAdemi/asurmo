class RenameLikesPostToActivity < ActiveRecord::Migration[5.0]
  def change
  	rename_column :likes, :post_id, :activity_id
  	rename_column :likes, :post_type, :activity_type
  end
end
