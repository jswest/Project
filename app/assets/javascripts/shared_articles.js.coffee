# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  initBindings()
  addUser = (message) ->
    $("<div/>").text(message).prependTo "#users"
    $("#log").scrollTop 0

initBindings = () ->
  $("form#new_share")
    .bind('ajax:beforeSend', () ->
    )
    .bind('ajax:success', (evt, data) ->
      $("#notice").html("Link shared.")
      initBindings()
    )
    .bind('ajax:error', (xhr, status, error) ->
    )
    .bind('ajax:complete', () ->
    )

  data = "/users/search.json"

  $("input#share_with").autocomplete(
    source: data
    minLength: 2
    select: (event, ui) ->
      console.log(ui.item)
      $("input#users").val($("input#users").val() + "," + ui.item.id)
      $("<li></li>").text(ui.item.value).appendTo("ul#shared_with")
      $("input#share_with").val("")
      return false
  )


