// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require datatables
//= require jquery-ui
//= require jquery-maskedinput
//= require jquery.atwho
//= require URI
//= require jquery.URI
//= require moment
//= require bootstrap-datetimepicker
//= require twitter/typeahead
//= require jquery.infinitescroll
//= require react
//= require react_ujs
//= require layout/components
//= require timeago
//= require magnific-popup
//= require turbolinks
//= require rails.validations
//= require_tree ./layout


function myFunction(elem) {
  console.log($(elem).next()[0].classList)
  $(elem).next()[0].classList.toggle("show");
  console.log($(elem).next()[0].classList)
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-box");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}

$(document).on("click", ".comment-toggle", function(){
 $($(this).closest('div').find('.comments-container')[0]).slideToggle();
});

function showModal(modalName) {
  $('#' + modalName).modal({
    showClose: false,
    fadeDuration: 1,
    fadeDelay: 1.0
  });
}
