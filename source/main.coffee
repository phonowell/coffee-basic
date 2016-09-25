#=include lib/basic.coffee
#=include lib/cursor.coffee
#=include lib/walk.coffee
#=include lib/use.coffee
#=include lib/pick.coffee

stepBy = (_name) ->
  $.search _name
  delay 200
  if $.isShape('hand') == true
    leftClick 1
    delay 5000
    pickUp()
    delay 500
    stepBy _name
  else
    switch _name
      when '基础药草'
        stepBy '血红药草'
      when '血红药草'
        stepBy '魔法药草'
      when '魔法药草'
        stepBy '阳光药草'
      when '阳光药草'
        stepBy '金色药草'

pickUp = ->
  $.pick '基础药草'
  $.pick '血红药草'
  $.pick '魔法药草'
  $.pick '阳光药草'
  $.pick '黄金药草'

#main
main = ->

  delay 1000

  $.use '丰收之歌', '1'
  stepBy '基础药草'
  $.walk 'random', 1

  main()

main()

onScriptExit = ->
  $.exit()