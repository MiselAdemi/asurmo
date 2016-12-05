class User < ActiveRecord::Base
  enum role: [:user, :moderator, :organization, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :moderators
  has_many :organizations, :through => :moderators

  accepts_nested_attributes_for :moderators, :organizations

  has_many :activities
end
