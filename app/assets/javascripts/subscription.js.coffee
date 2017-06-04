$(document).on "turbolinks:load", ->
  $('#payment-form button').on "click", (e)->
    document.getElementById('payment-loader').style.display = "block";

  Stripe.setPublishableKey($("meta[name='stripe-key']").attr("content"))

  $('#payment-form').submit (event) ->
    $form = $(this)

    if $(".card-fields").hasClass("hidden")
      # Use the default card
      $form.get(0).submit()
    else
      # Disable the submit button to prevent repeated clicks
      $form.find('button').prop 'disabled', true
      Stripe.card.createToken $form, stripeResponseHandler

    # Prevent the form from submitting with the default action
    false

  $('.use-different-card').on "click", (e)->
    $(".card-on-file").hide()
    $(".card-fields").removeClass("hidden")
    e.preventDefault()

stripeResponseHandler = (status, response) ->
  $form = $('#payment-form')
  if response.error
    # Show the errors on the form
    $form.find('.payment-errors').text response.error.message
    $form.find('button').prop 'disabled', false
  else
    # response contains id and card, which contains additional card details
    token = response.id
    # Insert the token into the form so it gets submitted to the server
    $form.append $('<input type="hidden" name="stripeToken" />').val(token)

    $form.append $('<input type="hidden" name="card_last4" />').val(response.card.last4)
    $form.append $('<input type="hidden" name="card_exp_month" />').val(response.card.exp_month)
    $form.append $('<input type="hidden" name="card_exp_year" />').val(response.card.exp_year)
    $form.append $('<input type="hidden" name="card_brand" />').val(response.card.brand)
    #$form.append $('<input type="hidden" name="plan_name" />').val(getParameterByName('plan'))
    # and submit
    $form.get(0).submit()
  return

getParameterByName = (name, url) ->
  if !url
    url = window.location.href
  name = name.replace(/[\[\]]/g, '\\$&')
  regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)')
  results = regex.exec(url)
  if !results
    return null
  if !results[2]
    return ''
  decodeURIComponent results[2].replace(/\+/g, ' ')
