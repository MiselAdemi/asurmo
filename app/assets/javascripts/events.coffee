# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#datetimepicker6').datetimepicker
    format: 'DD-MM-YYYY hh:mm:ss A'

  $('#datetimepicker7').datetimepicker
    useCurrent: false
    format: 'DD-MM-YYYY hh:mm:ss A'

  $('#datetimepicker6').on 'dp.change', (e) ->
    $('#datetimepicker7').data('DateTimePicker').minDate e.date
    return
  $('#datetimepicker7').on 'dp.change', (e) ->
    $('#datetimepicker6').data('DateTimePicker').maxDate e.date
    return
  return
