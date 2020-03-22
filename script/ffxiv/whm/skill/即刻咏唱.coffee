ts.即刻咏唱 = 0
cd.即刻咏唱 = 60e3

即刻咏唱 = ->

  unless level >= 18
    return false

  unless A_TickCount - ts.即刻咏唱 > cd.即刻咏唱
    return false

  $.press 'shift + 3'

  ts.即刻咏唱 = A_TickCount - cd.即刻咏唱 + cd.技能施放补正
  $.setInterval 监听即刻咏唱, cd.技能施放判断间隔
  return true

监听即刻咏唱 = ->
  unless hasStatus '即刻咏唱'
    return
  $.clearInterval 监听即刻咏唱
  ts.即刻咏唱 = A_TickCount - cd.技能施放补正