# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  $('.close-box').click ->
    $(this).parent('.front-page-article-wrapper').css( "display", "none" )
    article_id = $(this).parent('.front-page-article-wrapper').data("id")
    $.ajax
      url: '/users/update_front_page'
      data: {id: article_id}
      success: (data) ->
        $('section#front-page').html(data)
      type: 'POST'
