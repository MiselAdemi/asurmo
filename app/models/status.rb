class Status < ApplicationRecord
  acts_as_commentable

  belongs_to :user
end
