# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.sendComment = (id) ->
	if event.keyCode == 13
        $('#comment-form-' + id).submit()

window.sendCommentReply = (id) ->
	if event.keyCode == 13
        $('#comment-reply-form-' + id).submit()

window.togglerCommentReply = (id) ->
    $("#comment-reply-form-" + id).toggle()
    $("#reply-" + id).toggle()