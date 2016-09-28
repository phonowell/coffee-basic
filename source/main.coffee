#=include lib/basic.coffee
#include lib/cursor.coffee
#include lib/walk.coffee
#include lib/use.coffee
#include lib/pick.coffee

$.sort = ->
  $.find '自动整理'
  if x > 0
    $.move x + 3, y + 5
    delay 500
    leftClick 1
    delay 500

#main
main = ->

  delay 10000

  $.sort()

  $.move 0.5, 0.5

  main()

main()

onScriptExit = ->
  $.exit()