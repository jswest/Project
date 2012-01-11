# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  initBindings()

initBindings = () ->
  $("#new_article")
        .bind('ajax:beforeSend', () ->
        )
        .bind('ajax:success', (evt, data) ->
          $("#form-pane").html(data)
          $("#notice").html("Link saved. Now share it with your friends!")
          initBindings()
        )
        .bind('ajax:error', (xhr, status, error) ->
        )
        .bind('ajax:complete', () ->
        )

  $("#new_shared_article")
    .bind('ajax:beforeSend', () ->
    )
    .bind('ajax:success', (evt, data) ->
      $("#form-pane").html(data)
      $("#notice").html("Link shared! Share another?")
      initBindings()
    )
    .bind('ajax:error', (xhr, status, error) ->
    )
    .bind('ajax:complete', () ->
    )
