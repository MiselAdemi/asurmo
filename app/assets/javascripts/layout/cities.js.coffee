document.addEventListener("turbolinks:load", -> 
  states = $('#user_city_id').html()
  $('#user_country_id').change ->
    country = $('#user_country_id :selected').text()
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(states).filter("optgroup[label='#{escaped_country}']").html()
    if options
      $('#user_city_id').html(options)
      $('#user_city_id').parent().show()
    else
      $('#user_city_id').empty()
      $('#user_city_id').html("<option value=''>Please select a country first</option>")
)