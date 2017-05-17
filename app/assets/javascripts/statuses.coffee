jQuery ->
	data = ['tom', 'john']
	$('[data-behavior="autocomplete"').atwho(
		at: "@",
		'data' : "/users.json"
	)
