document.addEventListener("turbolinks:load", ->
#     jQuery ->
#         $( "#header-search-input" ).autocomplete(
#             source: "/users"
#         )
#         .data('ui-autocomplete')._renderItem = (ul, item) ->
#             $('<li></li>').data('item.autocomplete', item).append('<a href="/' + item.name + '">' + item.label + '</a>').appendTo ul
)
