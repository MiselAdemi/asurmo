class Interest < ActiveRecord::Base
  has_many :interests_list
  has_many :users, :through => :interests_list
end
