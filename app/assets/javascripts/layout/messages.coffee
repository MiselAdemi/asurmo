# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class RenderSync.MessageUserReceiverMessages extends RenderSync.View

  beforeInsert: ($el) ->
    $el.hide()
    @insert($el)

  afterInsert: ->
    if gon.current_user.id != parseInt(@$el[0].id)
      $('div.item .content .header:last').addClass('pull-right')
      $('div.item .content .well:last').removeClass('pull-right')
      $('div.item .content .well:last').addClass('well-sender')
      $("div.item .content .header img:last").insertAfter("div.item .content .header .time:last");

    @$el.fadeIn('slow')
