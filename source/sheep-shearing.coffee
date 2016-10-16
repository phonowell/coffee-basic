#=include lib/basic.coffee
#=include lib/act.coffee
#=include lib/use.coffee
#=include lib/pick.coffee

#main

_tsA = 0

main = ->

  _dtA = dateDiff 's', _tsA, now()
  if _dtA > 150
    _tsA = now()
    delay 1000
    $.use '丰收之歌', '1'

  $.findColor 'dff3bd'
  if x > 0
    $.move x + 30, y + 50
    delay 200
    leftClick 1
    delay 3500

  $.pick '羊毛'

  main()

#execute
$.move 0.5, 0.5
delay 200
leftClick 1
main()

#exit
onScriptExit = ->
  $.exit()