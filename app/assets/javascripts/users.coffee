# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#phone").mask("(999) 99-999-999")
  $("#datepicker").datepicker()
  $("time.timeago").timeago()

  # Upload avatar preview functionality

  $('#upload').change ->
    input = document.getElementById("upload")
    if input.files and input.files[0]
      reader = new FileReader

      reader.onload = (e) ->
        $('#img_prev').attr('src', e.target.result).width(200).height 200
        return

      reader.readAsDataURL input.files[0]

  $('#upload-avatar-button').click ->
    $('#upload').click()

  # Upload cover image preview functionality

  $('#upload-cover-file').change ->
    input = document.getElementById("upload-cover-file")
    if input.files and input.files[0]
      reader = new FileReader

      reader.onload = (e) ->
        $('#cover-img-prev').attr('src', e.target.result)
        return

      reader.readAsDataURL input.files[0]

  $('#upload-cover-button').click ->
    $('#upload-cover-file').click()
