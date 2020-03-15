回刺时间戳 = 0
回刺冷却 = 10e3

回刺 = ->

  unless A_TickCount - 回刺时间戳 > 回刺冷却
    return false

  unless black >= 80 and white >= 80
    return false

  中断咏唱()

  distance = getDistance()
  unless distance == 'near'
    短兵相接 true
    return false

  $.press 'alt + 1'

  $.setInterval 监听回刺, 技能施放判断间隔
  return true

监听回刺 = ->
  unless isUsed '魔回刺'
    return
  $.clearInterval 监听回刺
  回刺时间戳 = A_TickCount - 技能施放时间戳补正