# use admin
# include ../common/function

# fix
$.on 'f2', ->
  $.beep()
  $.setFixed()

# reload
$.on 'f5', ->
  reset()
  $.beep()
  $.reload()

$.on 'f6', ->
  [x, y] = $.getPosition()
  $.tip "#{x}, #{y}"

$.on 'f9', ->
  # [x, y] = $.getPosition()
  x = 1130
  y = 865
  color = $.getColor x, y
  # $.move x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'alt + f4', ->
  $.beep()
  reset()
  $.exit()