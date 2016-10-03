#=include lib/basic.coffee
#=include lib/act.coffee
#=include lib/use.coffee

#main

_tsA = 0
_tsB = 0
_tsC = 0

main = ->

  delay 500
  $.move 0.5, 0.5

  delay 1000
  $.act '切换装备', 'Tab'

  _dtA = dateDiff 's', _tsA, now()
  if _dtA > 60
    _tsA = now()
    delay 1000
    $.use '忍耐之歌', '8'
    delay 1000
    $.use '影子隐身术', '5'

  _dtB = dateDiff 's', _tsB, now()
  if _dtB > 300
    _tsB = now()
    delay 1000
    $.use '樱时雨', '1'

  _dtC = dateDiff 's', _tsC, now()
  if _dtC > 15
    _tsC = now()
    delay 1000
    $.use '影子束缚术', '3'
    delay 1000
    $.use '烟幕术', '4'

  #delay 1000
  #$.use '手里剑风暴', '7'
  #delay 1000
  #$.use '手里剑爆破术', '6'
  #delay 1000
  #$.use '螺旋斩', '2'

  delay 500
  $.getSkill()
  delay 500
  $.updateSkill()

  main()

#execute
$.move 0.5, 0.5
delay 200
leftClick 1
main()

#exit
onScriptExit = ->
  $.exit()