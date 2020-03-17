ts.焦热 = 0
cd.焦热 = 10e3

焦热 = ->

  unless A_TickCount - ts.焦热 > cd.焦热
    $.beep()
    return false

  unless A_TickCount - ts.赤神圣 < 15e3
    return false

  摇荡()
  
  $.setInterval 监听焦热, cd.技能施放判断间隔
  return true

监听焦热 = ->
  unless isUsed '焦热'
    return
  $.clearInterval 监听焦热
  ts.焦热 = A_TickCount - cd.技能施放补正