醒梦时间戳 = 0
醒梦冷却 = 60e3

醒梦 = ->

  unless A_TickCount - 醒梦时间戳 > 醒梦冷却
    return false

  mp = getMp()
  if mp > 50
    return false

  $.press 'shift + 3'
  
  醒梦时间戳 = A_TickCount - 醒梦冷却 + 技能施放时间戳补正
  $.setInterval 监听醒梦, 技能施放判断间隔
  return true

监听醒梦 = ->
  unless hasStatus '醒梦'
    return
  $.clearInterval 监听醒梦
  醒梦时间戳 = A_TickCount - 技能施放时间戳补正