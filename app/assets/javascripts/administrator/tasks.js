$(document).on("turbolinks:load", function() {
  $('body').on("click", '.edit_task input[type=checkbox]', function() {
    $(this).parent().parent('form').submit();
  });
});
