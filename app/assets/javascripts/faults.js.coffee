$(document).ready ->
  $(".country_selection").on "change", ->
    $.ajax
      url: "/home/get_cities"
      type: "GET"
      dataType: "script"
      data:
        country_code: $('.country_selection option:selected').val()
