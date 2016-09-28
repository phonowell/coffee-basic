$.screen.width = Plugin.Sys.GetScRX()
$.screen.height = Plugin.Sys.GetScRY()

#random
$.rnd = (_min, _max) =>
  randomize()
  return int((_max - _min + 1) * rnd() + _min)

#move
$.move = (_x, _y) ->
  if _x > 0 and _y > 0
    if _x <= 1
      _x = $.screen.width * _x
    if _y <= 1
      _y = $.screen.height * _y
    moveTo _x, _y

#find image
$.find = (_name) ->
  findPic 0, 0, $.screen.width, $.screen.height, "D:\按键精灵\image\#{_name}.bmp", 0.9, x, y

#find color
$.findColor = (_color) ->
  _color = ucase _color
  _r = left _color, 2
  _g = mid _color, 3, 2
  _b = right _color, 2
  _color = "#{_b}#{_g}#{_r}"
  findCenterColor 0, 0, $.screen.width, $.screen.height, _color , x, y

#say
$.say = (_text) ->
  keyPress 'Enter', 1
  delay 200
  SayString _text
  delay 200
  keyPress 'Enter', 1
  delay 200
  keyPress 'Enter', 1

#exit
$.exit = ->
  leftUp 1
  rightUp 1
  keyUp 'w', 1
  keyUp 'a', 1
  keyUp 's', 1
  keyUp 'd', 1
  keyUp 'Ctrl', 1
  keyUp 'Alt', 1
  keyUp 'Shift', 1