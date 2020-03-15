飞刺时间戳 = 0
飞刺冷却 = 25e3

飞刺 = ->

  unless A_TickCount - 飞刺时间戳 > 飞刺冷却
    return false
  
  $.press 'ctrl + 1'
  
  飞刺时间戳 = A_TickCount - 飞刺冷却 + 技能施放时间戳补正
  $.setInterval 监听飞刺, 技能施放判断间隔
  return true

监听飞刺 = ->
  unless isUsed '飞刺'
    return
  $.clearInterval 监听飞刺
  飞刺时间戳 = A_TickCount - 技能施放时间戳补正