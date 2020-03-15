焦热时间戳 = 0
焦热冷却 = 10e3

焦热 = ->

  unless A_TickCount - 焦热时间戳 > 焦热冷却
    $.beep()
    return false

  unless A_TickCount - 赤神圣时间戳 < 15e3
    return false

  摇荡()
  
  $.setInterval 监听焦热, 技能施放判断间隔
  return true

监听焦热 = ->
  unless isUsed '焦热'
    return
  $.clearInterval 监听焦热
  焦热时间戳 = A_TickCount - 技能施放时间戳补正