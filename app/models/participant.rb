class Participant < ApplicationRecord
  belongs_to :campain
  belongs_to :user
end
