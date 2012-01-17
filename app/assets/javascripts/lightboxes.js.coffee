$ ->
  initBindings()
  $("#share-this-header").click ->
    clear_out()
    $("#share-this-gloss").show()
    $("#share-this-lightbox").show()

  $("#users-header").click ->
    $("#users-gloss").show()
    $("#users-lightbox").show()
  
  $("#share-this-gloss").click ->
    $(this).hide()
    $("#share-this-lightbox").hide()
    
  $("#users-gloss").click ->
    $(this).hide()
    $("#users-lightbox").hide()
    
  $(".share-this-button").click ->
    article_id = $(this).parent().attr("article_id")
    $.get("/shared_articles/new", {article_id: article_id}, (data) ->
      $("#share-this-lightbox").html(data)
    )
    $("#share-this-gloss").show()
    $("#share-this-lightbox").show()
  
  $(".share-with-button").click ->
    user_id = $(this).parent().attr("user_id")
    $.get("/shared_articles/new", {user_id: user_id}, (data) ->
      $("#share-this-lightbox").html(data)
      initBindings()
    )
    $("#users-gloss").hide()
    $("#users-lightbox").hide()
    $("#share-this-gloss").show()
    $("#share-this-lightbox").show()
    
  $(".x-box-lightbox").live("click",  ->
    $("#share-this-gloss").hide()
    $("#share-this-lightbox").hide()
    $("#users-gloss").hide()
    $("#users-lightbox").hide()
  )
    
  clear_out = () ->
    $("input#url").val("")
    $("input#users").val("")
    $("input#share_with").val("")
    $("ul#shared_with").html("")
    $("input#blurb").val("")
    $("input#user_id").val("")
    $("input#article_id").val("")


  addUser = (message) ->
    $("<div/>").text(message).prependTo "#users"
    $("#log").scrollTop 0

initBindings = () ->
  #alert "INIT"
  $("form#new_share")
    .bind('ajax:beforeSend', () ->
    )
    .bind('ajax:success', (evt, data) ->
      $("#notice").html("Link shared.")
      initBindings()
      $("#share-this-gloss").hide()
      $("#share-this-lightbox").hide()
    )
    .bind('ajax:error', (xhr, status, error) ->
      alert "ERroR"
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