class Country < ApplicationRecord
	has_many :locations, -> { where("population > ?", 30000 ) }
end
