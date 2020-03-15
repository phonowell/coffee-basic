交剑时间戳 = 0
交剑冷却 = 35e3

交剑 = ->

  unless A_TickCount - 交剑时间戳 > 交剑冷却
    return false

  distance = getDistance()
  unless distance == 'near'
    return false

  $.press 'ctrl + 0'
  
  交剑时间戳 = A_TickCount - 交剑冷却 + 技能施放时间戳补正
  $.setInterval 监听交剑, 技能施放判断间隔
  return true

监听交剑 = ->
  unless isUsed '交剑'
    return
  $.clearInterval 监听交剑
  交剑时间戳 = A_TickCount - 技能施放时间戳补正