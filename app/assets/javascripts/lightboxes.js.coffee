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
    
  $("#share-this-button").click ->
    $("#share-this-gloss").css( "display", "block" )
    $("#share-this-lightbox").css( "display", "block" )  
  
