# function

beep = ->
  $.beep()

# bind

$.on 'f1', ->
  [x, y] = $.getPosition()
  color = $.getColor x, y
  alert "current color is #{color}"

$.on 'f2', ->
  [x, y] = $.find '#fff', [0, 0], [100, 100]
  alert "find #fff at #{x}, #{y}"

$.on 'f3', ->
  beep()

$.on 'ctrl + f12', ->
  $.exit()