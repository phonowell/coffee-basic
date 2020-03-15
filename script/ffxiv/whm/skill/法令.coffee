法令时间戳 = 0
法令冷却 = 45e3

法令 = ->

  unless A_TickCount - 法令时间戳 > 法令冷却
    return false

  $.press 'ctrl + 4'

  法令时间戳 = A_TickCount - 法令冷却 + 技能施放时间戳补正
  $.setInterval 监听法令, 技能施放判断间隔
  return true

监听法令 = ->
  unless isUsed '法令'
    return
  $.clearInterval 监听法令
  法令时间戳 = A_TickCount - 技能施放时间戳补正