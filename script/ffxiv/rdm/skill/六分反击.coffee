六分反击时间戳 = 0
六分反击冷却 = 35e3

六分反击 = ->

  unless A_TickCount - 六分反击时间戳 > 六分反击冷却
    return false

  $.press 'ctrl + 6'
  
  六分反击时间戳 = A_TickCount - 六分反击冷却 + 技能施放时间戳补正
  $.setInterval 监听六分反击, 技能施放判断间隔
  return true

监听六分反击 = ->
  unless isUsed '六分反击'
    return
  $.clearInterval 监听六分反击
  六分反击时间戳 = A_TickCount - 技能施放时间戳补正