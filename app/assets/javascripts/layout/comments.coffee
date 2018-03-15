# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# window.sendComment = (id) ->
# 	if event.keyCode == 13
#         $('#comment-form-' + id).submit()
#
# window.sendCommentReply = (id) ->
# 	if event.keyCode == 13
#         $('#comment-reply-form-' + id).submit()
#
# window.togglerCommentReply = (id) ->
#     $("#comment-reply-form-" + id).toggle()
#     $("#reply-" + id).toggle()

$(document).on "turbolinks:load", ->
	$('.new_comment').on "keypress", (e) ->
		if e && e.keyCode == 13
			e.preventDefault()
			$(this).submit()
			$(this).find("textarea").val('')

	$('a.load-more').on "click", (e) ->
		e.preventDefault()

		$(this).hide()
		$(this).prev().show()

		activity_id = $(this).attr('data-activity-id')
		last_id = $(this).parent().parent().children('div').children('.comment').last().attr('data-id')

		console.log(activity_id)
		console.log(last_id)

		$.ajax
  		type: 'GET'
		  url: $(this).attr('href')
		  data: id: last_id, activity_id: activity_id
		  dataType: 'script'
			beforeSend: (xhr) ->
    		xhr.setRequestHeader 'Authorization', 'Bearer ' + localStorage.user_token
		  success: ->
				$(this).prev().hide()
				$(this).show()
