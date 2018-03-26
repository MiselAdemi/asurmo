json.array!(@users) do |user|
	json.id user.id
	json.name user.slug
	json.label user.full_name
	json.first_name user.first_name
	json.last_name user.last_name
end
