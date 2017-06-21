document.addEventListener("turbolinks:load", ->
	$('#newCampainModal').on 'shown.bs.modal', ->
		$("#new_campain").validate
			rules:
				"campain[name]":
					required: true
					minlength: 3
					maxlength: 25
				"campain[avatar]":
					required: true
					accept: "image/*"
)