倍增时间戳 = 0
倍增冷却 = 110e3

倍增 = ->

  unless A_TickCount - 倍增时间戳 > 倍增冷却
    return false

  if A_TickCount - 回刺时间戳 < 魔三连冷却
    return false

  unless black >= 40 and black <= 70
    return false

  unless white >= 40 and white <= 70
    return false

  $.press 'ctrl + 8'
  
  倍增时间戳 = A_TickCount - 倍增冷却 + 技能施放时间戳补正
  $.setInterval 监听倍增, 技能施放判断间隔
  return true

监听倍增 = ->
  unless isUsed '倍增'
    return
  $.clearInterval 监听倍增
  倍增时间戳 = A_TickCount - 技能施放时间戳补正
  短兵相接时间戳 = 0
  移转时间戳 = 0
  交剑时间戳 = 0