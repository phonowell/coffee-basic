鼓励时间戳 = 0
鼓励冷却 = 120e3

鼓励 = ->

  unless A_TickCount - 鼓励时间戳 > 鼓励冷却
    return false

  unless A_TickCount - 回刺时间戳 < 回刺冷却
    return false

  $.press 'ctrl + 7'
  
  鼓励时间戳 = A_TickCount - 鼓励冷却 + 技能施放时间戳补正
  $.setInterval 监听鼓励, 技能施放判断间隔
  return true

监听鼓励 = ->
  unless isUsed '鼓励'
    return
  $.clearInterval 监听鼓励
  鼓励时间戳 = A_TickCount - 技能施放时间戳补正