namespace :import do

	task countries: :environment do
		desc "Import countries from csv"
		counter = 0

		CSV.foreach("country.csv", headers: true) do |row|
			country = Country.create(code: row["code"], name: row["name"])
			counter += 1 if country.persisted?
		end

		puts "Imported #{counter} countries"
	end

	task cities: :environment do
		desc "Import cities from csv"
		counter = 0

		CSV.foreach("worldcitiespop.csv", headers: true, :encoding => 'windows-1251:utf-8') do |row|
			city = Location.create(country: row["country"], city: row["city"], accentcity: row["accentcity"], region: row["region"], population: row["population"], latitude: row["latitude"], longitude: row["longitude"])
			counter += 1 if city.persisted?
		end

		puts "Imported #{counter} cities"
	end
end