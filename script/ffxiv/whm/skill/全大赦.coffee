全大赦时间戳 = 0
全大赦冷却 = 60e3

全大赦 = ->

  unless A_TickCount - 全大赦时间戳 > 全大赦冷却
    return false

  unless 能力技冷却判断()
    return false

  $.press 'ctrl + 8'

  全大赦时间戳 = A_TickCount - 全大赦冷却 + 技能施放时间戳补正
  $.setInterval 监听全大赦, 技能施放判断间隔
  return true

监听全大赦 = ->
  unless isUsed '全大赦'
    return
  $.clearInterval 监听全大赦
  全大赦时间戳 = A_TickCount - 技能施放时间戳补正