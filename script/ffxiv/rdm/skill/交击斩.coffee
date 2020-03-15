交击斩时间戳 = 0
交击斩冷却 = 10e3

交击斩 = ->

  unless A_TickCount - 交击斩时间戳 > 交击斩冷却
    return false

  unless A_TickCount - 回刺时间戳 < 魔三连冷却
    return false

  unless black >= 50 and white >= 50
    return false

  $.press 'alt + minus'
  
  $.setInterval 监听交击斩, 技能施放判断间隔
  return true

监听交击斩 = ->
  unless isUsed '魔交击斩'
    return
  $.clearInterval 监听交击斩
  交击斩时间戳 = A_TickCount - 技能施放时间戳补正