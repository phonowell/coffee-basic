即刻咏唱时间戳 = 0
即刻咏唱冷却 = 60e3

即刻咏唱 = ->

  unless A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却
    return false

  unless A_TickCount - 回刺时间戳 > 回刺冷却
    return false

  if black > 70 or white > 70
    return false

  if hasStatus '连续咏唱'
    return false

  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'
  if isBR and isWR
    return

  $.press 'shift + 2'
  
  即刻咏唱时间戳 = A_TickCount - 即刻咏唱冷却 + 技能施放时间戳补正
  $.setInterval 监听即刻咏唱, 技能施放判断间隔
  return true

监听即刻咏唱 = ->
  unless hasStatus '即刻咏唱'
    return
  $.clearInterval 监听即刻咏唱
  即刻咏唱时间戳 = A_TickCount - 技能施放时间戳补正