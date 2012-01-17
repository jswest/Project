# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  position_articles()

position_articles = () ->
  articles = sort_by_size( $(".front-page-article-wrapper") )
  grid = [[0,0,0,0],[0,0,0,0],[0,0,0,0]]

  for article in articles
    fits = false
    y = 0
    x = 0
    while y < grid.length and not fits
      while x < grid[0].length and not fits
        fits = check_boundaries(x,y,article[0],grid)
        if fits
          mark_grid(x,y,article,grid)
        x++
      x = 0
      y++



check_boundaries = (x,y,size,grid) ->
  dimensions = get_dimensions(size)
  original_y = y
  original_x = x

  while x < original_x + dimensions[0]
    while y < original_y + dimensions[1]
      if x >= grid[0].length or y >= grid.length or grid[y][x] > 0
        return false
      y++
    y = original_y
    x++
  return true

get_dimensions = (size) ->
  random = Math.floor( Math.random()*3 )
  switch size
    when "2" then return [1,2]
    when "3" then return [1,3]
    when "4" then return [2,2]
    else return [1,1]

sort_by_size = ( array ) ->
  sorted = []
  array.each( () ->
    sorted.push([$(this).attr("article_size"), $(this).attr("id")])
  )
  console.log(sorted)
  return sorted

mark_grid = (x,y,article,grid) ->
  size = article[0]
  id = article[1]
  i = x
  j = y
  $("#" + id).addClass("x" + x + "y" + y)
  dimensions = get_dimensions(size)
  while i < x + dimensions[0]
    while j < y + dimensions[1]
      grid[j][i] = size
      j++
    j = y
    i++
