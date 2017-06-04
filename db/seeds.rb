require "open-uri"

#Country.delete_all
#open("http://openconcept.ca/sites/openconcept.ca/files/country_code_drupal_0.txt") do |countries|
#  countries.read.each_line do |country|
#    code, name = country.chomp.split("|")
#    Country.create!(:code => code, :name => name)
#  end
#end

Plan.create(:name => "free", :organizations_quota => 1, :campains_quota => 2, :events_quota => 2)
Plan.create(:name => "starter", :organizations_quota => 2, :campains_quota => 4, :events_quota => 4)
Plan.create(:name => "basic", :organizations_quota => 4, :campains_quota => 8, :events_quota => 8)
Plan.create(:name => "pro", :organizations_quota => 10, :campains_quota => 20, :events_quota => 20)