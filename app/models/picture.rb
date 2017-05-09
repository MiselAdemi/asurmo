class Picture < ApplicationRecord
  acts_as_votable
  acts_as_commentable

  belongs_to :album
  belongs_to :user

  mount_uploader :picture, PictureUploader
end
