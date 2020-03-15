即刻咏唱时间戳 = 0
即刻咏唱冷却 = 60e3

即刻咏唱 = ->

  unless A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却
    return false

  $.press 'shift + 3'

  即刻咏唱时间戳 = A_TickCount - 即刻咏唱冷却 + 技能施放时间戳补正
  $.setInterval 监听即刻咏唱, 技能施放判断间隔
  return true

监听即刻咏唱 = ->
  unless hasStatus '即刻咏唱'
    return
  $.clearInterval 监听即刻咏唱
  即刻咏唱时间戳 = A_TickCount - 技能施放时间戳补正