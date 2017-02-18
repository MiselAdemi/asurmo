class Member < ActiveRecord::Base
  enum role: [:member, :moderator, :owner]
  belongs_to :user
  belongs_to :organization
end
