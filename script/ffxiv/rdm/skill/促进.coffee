促进时间戳 = 0
促进冷却 = 55e3

促进 = ->

  unless A_TickCount - 促进时间戳 > 促进冷却
    return false

  unless A_TickCount - 赤疾风时间戳 < 2e3
    return false

  unless A_TickCount - 回刺时间戳 > 魔三连冷却
    return false

  if black > 70 or white > 70
    return false

  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'
  if isBR or isWR
    return false

  $.press 'ctrl + 3'
  
  促进时间戳 = A_TickCount - 促进冷却 + 技能施放时间戳补正
  $.setInterval 监听促进, 技能施放判断间隔
  return true

监听促进 = ->
  unless isUsed '促进'
    return
  $.clearInterval 监听促进
  促进时间戳 = A_TickCount - 技能施放时间戳补正