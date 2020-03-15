神名时间戳 = 0
神名冷却 = 60e3

神名 = ->

  unless A_TickCount - 神名时间戳 > 神名冷却
    return false

  unless 能力技冷却判断()
    return false

  $.press 'ctrl + 6'

  神名时间戳 = A_TickCount - 神名冷却 + 技能施放时间戳补正
  $.setInterval 监听神名, 技能施放判断间隔
  return true

监听神名 = ->
  unless isUsed '神名'
    return
  $.clearInterval 监听神名
  神名时间戳 = A_TickCount - 技能施放时间戳补正