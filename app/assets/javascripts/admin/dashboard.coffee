$(document).on "click", "#menu-toggle", (e)->
  e.preventDefault()
  $("#wrapper").toggleClass("toggled")
