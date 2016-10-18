#=include lib/basic.coffee
#=include lib/act.coffee
#=include lib/use.coffee

#main

_tsA = 0

main = ->

  delay 500
  $.move 0.5, 0.5

  _dtA = dateDiff 's', _tsA, now()
  if _dtA > 40
    _tsA = now()
    delay 1000
    $.use '忍耐之歌', '8'
    delay 1000
    $.use '迷惑的演奏', '9'
    delay 1000
    $.use '脱离险境', 'F11'

  delay 1000
  $.use '摇篮曲', 'F9'

  #delay 500
  #$.getSkill()
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