#=include lib/init.coffee
#=include lib/image.coffee
#=include lib/get.coffee

posX = 0
posY = 0

#step by
$.step = (_first, _second, _third) ->

  if posX == 0
    delay 1000
    $.find '合成材料'
    posX = x
    posY = y

  $.get _first, 1
  $.move posX + 20, posY + 50
  delay 1000
  leftClick 1
  delay 500

  $.get _second, 1
  $.move posX + 80, posY + 50
  delay 1000
  leftClick 1
  delay 500

  $.get _third, 1
  $.move posX + 140, posY + 50
  delay 1000
  leftClick 1
  delay 500

$.confirm = ->
  delay 500
  $.find '合成按钮'
  if x > 0
    $.move x + 5, y + 5
    delay 500
    leftClick 1

  delay 6500

$.sort = ->
  $.find '自动整理'
  if x > 0
    $.move x + 3, y + 5
    delay 500
    leftClick 1
    delay 500

#main
$.main = ->

  $.move 0.5, 0.5
  delay 200
  leftClick 1

  $.sort()
  $.step '生命药草', '基础药草', '生命药水50点'
  $.confirm()

  $.main()

$.main()