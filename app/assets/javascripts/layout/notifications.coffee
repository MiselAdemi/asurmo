class Notifications
	constructor: ->
		@notifications = $(".notification-btn")
		@setup() if @notifications.length > 0 

	setup: -> 
		$(".notification-btn").on "click", @handleClick
		$.ajax(
			url: "/notifications.json"
			dataType: "JSON"
			method: "GET"
			success: @handleSuccess
		)

	handleClick: (e) =>
		$.ajax(
			url: "/notifications/mark_as_read"
			dataType: "JSON"
			method: "POST"
			success: @updateCounter
		)

	handleSuccess: (data) =>
		count = 0
		$.map data, (notification) ->
			if notification.read == false
				count++

		if count > 0
			$(".notification-btn span").text(count)
		else
			$(".notification-btn span").text("")

	updateCounter: =>
		$.ajax(
			url: "/notifications.json"
			dataType: "JSON"
			method: "GET"
			success: @handleSuccess
		)

document.addEventListener("turbolinks:load", -> 
	if Notification.permission == "default"
		Notification.requestPermission()

	new Notifications
)