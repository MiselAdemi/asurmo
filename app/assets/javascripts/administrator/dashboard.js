$(document).on("turbolinks:load", function() {
  $('ul.tabs li').click(function(e) {
    e.preventDefault()

    var tab_id = $(this).attr('data-tab')

    $('ul.tabs li a').removeClass('tab-active')
    $('.tab-content').removeClass('current')

    $('a', this).addClass('tab-active')
    $("#" + tab_id).addClass('current')
  })
});
