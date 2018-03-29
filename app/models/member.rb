class Member < ApplicationRecord
  enum role: [:member, :moderator, :admin]
  belongs_to :user
  belongs_to :organization

  validates :user_id, :presence => true
  validates :organization_id, :presence => true

  attribute :email, :string

  before_validation :set_user_id, if: :email?

  def set_user_id
    existing_user = User.find_by(email: email)
    self.user = User.invite!(email: email)
  end
end
