class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :subscriptions_quota
end
