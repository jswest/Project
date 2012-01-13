$ ->
  
  $("#share-this-header").click ->
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
    )
    $("#users-gloss").hide()
    $("#users-lightbox").hide()
    $("#share-this-gloss").show()
    $("#share-this-lightbox").show()
