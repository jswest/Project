$ ->
  $("#share-this-header").click ->
    $("#share-this-gloss").css( "display", "block" )
    $("#share-this-lightbox").css( "display", "block" )
    
  $("#users-header").click ->
    $("#users-gloss").css( "display", "block" )
    $("#users-lightbox").css( "display", "block" ) 
  
  $("#share-this-gloss").click ->
    $(this).css("display", "none")
    $("share-this-lightbox").css("display", "none")
    
  $("#users-gloss").click ->
    $(this).css("display", "none")
    $("users-lightbox").css("display", "none")
    
  $(".share-this-button").click ->
    article_id = $(this).parent().attr("article_id")
    $.get("/shared_articles/new", {article_id: article_id}, -> (data)
      $("#share-this-lightbox").html(data)
    )
    $("#share-this-gloss").css( "display", "block" )
    $("#share-this-lightbox").css( "display", "block" )  
