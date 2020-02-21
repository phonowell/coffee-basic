# use admin
# include ../common/function

# reload
$.on 'f5', ->
  reset()
  $.beep()
  $.reload()

$.on 'f6', ->
  [x, y] = $.findColor '#58483e'
  $.move x, y
  $.tip "#{x}, #{y}"

$.on 'f9', ->
  # [x, y] = $.getPosition()
  x = 1150
  y = 860
  color = $.getColor x, y
  $.move x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'alt + f4', ->
  $.beep()
  reset()
  $.exit()