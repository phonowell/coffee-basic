神速咏唱时间戳 = 0
神速咏唱冷却 = 150e3

神速咏唱 = ->

  unless A_TickCount - 神速咏唱时间戳 > 神速咏唱冷却
    return false

  $.press 'alt + 9'

  神速咏唱时间戳 = A_TickCount - 神速咏唱冷却 + 技能施放时间戳补正
  $.setInterval 监听神速咏唱, 技能施放判断间隔
  return true

监听神速咏唱 = ->
  unless hasStatus '神速咏唱'
    return
  $.clearInterval 监听神速咏唱
  神速咏唱时间戳 = A_TickCount - 技能施放时间戳补正