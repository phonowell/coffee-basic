#=include lib/basic.coffee
#=include lib/cursor.coffee
#=include lib/walk.coffee
#=include lib/use.coffee
#=include lib/pick.coffee

gather = (_name, _item) ->
  $.pick _item
  $.search _name
  delay 200
  if x > 0 and $.isShape('hand') == true
    leftClick 1
    delay 2000
  else
    $.walk 'random', 0.5

#main
_ts = 0
main = ->

  delay 1000

  _dt = dateDiff 's', _ts, now()
  if _dt > 60
    _ts = now()
    $.use '丰收之歌', '1'

  gather '金色药草', '黄金药草'

  main()

main()

onScriptExit = ->
  $.exit()