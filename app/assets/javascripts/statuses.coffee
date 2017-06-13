jQuery ->
	$('[data-behavior="autocomplete"').atwho(
		at: "@",
		'data' : "/users.json"
	)
	.atwho(
		at: ":",
		displayTpl: "<li><img src='https://raw.githubusercontent.com/wingman172/asurmo/master/public/assets/emoji/${name}.png' height='20' width='20'/> ${name} </li>",
  	insertTpl: ":${name}:",
		'data': "https://raw.githubusercontent.com/wingman172/asurmo/emoji-popup-picker/public/emoji.json"
	)