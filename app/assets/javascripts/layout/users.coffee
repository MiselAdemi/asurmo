# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener("turbolinks:load", ->
  $("#phone").mask("(999) 99-999-999")
  $("#datepicker").datepicker()
  # $("time.timeago").timeago()
  # $('.dropdown-toggle').dropdown()

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

  window.toggler = (divId) ->
    $(".comment-box-" + divId).toggle()

  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next a').attr('href')

      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').html("<div class='loader2'></div>")
        $.getScript(url)

    $(window).scroll()


# Typehead autocomplete search

  url_page = window.location.href.split("/")[5]

  engine = new Bloodhound(
    datumTokenizer: (d) ->
      Bloodhound.tokenizers.whitespace d.email
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: window.location.href.replace(url_page, "") + 'autocomplete?type=' + url_page + '&query=%QUERY'
      wildcard: '%QUERY')
  promise = engine.initialize()
  promise.done(->
    #console.log 'success!'
  ).fail ->
    console.log 'err!'
  $('.typeahead').typeahead null,
    name: 'engine'
    displayKey: 'email'
    source: engine.ttAdapter()

  $('[data-behavior="autocomplete"').on 'change', (obj, datum) ->
    $("#status-hidden-textarea").val($("#status-textarea")[0].innerText)
    placeCaretAtEnd(($('#status-textarea').get(0)))

  placeCaretAtEnd = (el) ->
    el.focus()
    if typeof window.getSelection != 'undefined' and typeof document.createRange != 'undefined'
      range = document.createRange()
      range.selectNodeContents el
      range.collapse false
      sel = window.getSelection()
      sel.removeAllRanges()
      sel.addRange range
    else if typeof document.body.createTextRange != 'undefined'
      textRange = document.body.createTextRange()
      textRange.moveToElementText el
      textRange.collapse false
      textRange.select()

)
