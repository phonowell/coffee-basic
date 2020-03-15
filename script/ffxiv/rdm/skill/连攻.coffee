连攻时间戳 = 0
连攻冷却 = 10e3

连攻 = ->

  unless A_TickCount - 连攻时间戳 > 连攻冷却
    return false

  unless A_TickCount - 交击斩时间戳 < 魔三连冷却
    return false

  unless black >= 25 and white >= 25
    return false

  $.press 'ctrl + 2'
  
  $.setInterval 监听连攻, 技能施放判断间隔
  return true

监听连攻 = ->
  unless isUsed '魔连攻'
    return
  $.clearInterval 监听连攻
  连攻时间戳 = A_TickCount - 技能施放时间戳补正