# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.typeahead').on 'typeahead:selected', ->
    value = $("#search-field").val()
    update_field()

  $('.typeahead').on 'input', ->
    value = $("#search-field").val()
    update_field()

  update_field = ->
    value = $("#search-field").val()
    $('.hidden-autocomplete').val(value)
