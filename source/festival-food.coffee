#=include lib/basic.coffee
#=include lib/get.coffee
#=include lib/use.coffee

#step by
$.step = (_name) ->
  delay 200
  $.get _name, 'all'
  delay 200
  $.find '庆典料理空位'
  if x > 0
    $.move x + 20, y + 50
    delay 200
    leftClick 1
    delay 500

$.confirm = ->
  delay 500
  $.find '庆典料理开始按钮'
  if x > 0
    $.move x + 5, y + 5
    delay 200
    leftClick 1

  delay 6500

#main
main = ->

  keyPress '9', 1
  $.step '大麦茶'
  $.step '大麦茶'
  $.confirm()

  delay 500
  $.updateSkill()

  main()

#execute
main()

#exit
onScriptExit = ->
  $.exit()