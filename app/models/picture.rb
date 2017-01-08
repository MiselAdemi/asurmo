class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :user

  mount_uploader :picture, PictureUploader
end
