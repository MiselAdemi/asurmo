# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->

	$('.typeahead').on 'typeahead:selected', ->
		value = $("#search-field").val()
		update_field()

	$('.typeahead').on 'input', ->
		value = $("#search-field").val()
		update_field()

	update_field = ->
		value = $("#search-field").val()
		$('.hidden-autocomplete').val(value)

	$("#avatar_upload").on 'change', ->
		input = $("#avatar_upload")[0]
		if input.files and input.files[0]
  		reader = new FileReader

  		reader.onload = (e) ->
    		$('#img_prev').attr('src', e.target.result)

  		reader.readAsDataURL input.files[0]

	$(".new-organization-form-field").on "keyup", (e) ->
		if $('.new-organization-form-field').val() == ''
			$(".new_organization .btn").attr('disabled', true)
			return
			
		$(".new_organization .btn").attr('disabled', false)