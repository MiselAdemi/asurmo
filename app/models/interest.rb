class Interest < ApplicationRecord
	has_many :interesttaggings
	has_many :users, :through => :interesttaggings
end
