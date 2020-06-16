# use admin
# include ../common/function/*

# fix
$.on 'f2', ->
  $.beep()
  $.setFixed()

# reload
$.on 'f5', ->
  resetKey()
  $.beep()
  $.reload()

$.on 'f6', ->
  [x, y] = $.getPosition()
  $.tip "#{x}, #{y}"

$.on 'f9', ->
  [x, y] = $.getPosition()
  x = 1803
  y = 764
  color = $.getColor x, y

  # $.move x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'alt + f4', ->
  $.beep()
  resetKey()
  $.exit()