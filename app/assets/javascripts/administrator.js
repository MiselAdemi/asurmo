//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require jquery-maskedinput
//= require turbolinks
//= require rails.validations
//= require Chart.bundle
//= require chartkick
//= require trix
//= require_tree ./administrator

function showModal(modalName) {
  $('#' + modalName).modal({
    showClose: false,
    fadeDuration: 1,
    fadeDelay: 1.0
  });

  $('.modal').on($.modal.OPEN, function(event, modal) {
    $('form').enableClientSideValidations();
  });
}

window.ClientSideValidations.callbacks.element.fail = function(element, message, callback) {
  callback();
  if (element.data('valid') !== false) {
    element.closest('form').find(':submit').prop('disabled', true);
  }
}

window.ClientSideValidations.callbacks.element.pass = function(element, callback) {
  // Take note how we're passing the callback to the hide()
  // method so it is run after the animation is complete.
  element.closest('form').find(':submit').prop('disabled', false);
}
