#=include lib/init.coffee
#=include lib/image.coffee
#=include lib/get.coffee

xA = 0
yA = 0
xB = 0
yB = 0

$.step = (_name, _task) ->

  if xA == 0
    delay 1000
    $.find '金属转换材料'
    xA = x
    yA = y

  $.find _task
  if x > 0
    $.move x + 20, y + 5
    delay 500
    leftClick 1

  $.get _name, 'all'
  $.move xA + 20, yA + 50
  delay 1000
  leftClick 1
  delay 500

$.confirm = ->
  delay 500
  $.find '转换按钮'
  if x > 0
    $.move x + 5, y + 5
    delay 500
    leftClick 1

  delay 3000

  if xB == 0
    delay 1000
    $.find '金属转换轮盘'
    xB = x
    yB = y

  $.move xB + 5, yB + 5
  delay 700
  leftClick 1
  delay 350
  leftClick 1
  delay 350
  leftClick 1
  delay 350
  leftClick 1

  delay 7000

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
  #$.step '不知名的矿石碎片', '铁矿石碎片转换'
  $.step '铁矿石碎片', '铜矿石碎片转换'
  $.confirm()

  $.main()

$.main()