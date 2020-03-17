ts.即刻咏唱 = 0
cd.即刻咏唱 = 60e3

即刻咏唱 = ->

  unless A_TickCount - ts.即刻咏唱 > cd.即刻咏唱
    return false

  unless A_TickCount - ts.回刺 > cd.回刺
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
  
  ts.即刻咏唱 = A_TickCount - cd.即刻咏唱 + cd.技能施放补正
  $.setInterval 监听即刻咏唱, cd.技能施放判断间隔
  return true

监听即刻咏唱 = ->
  unless hasStatus '即刻咏唱'
    return
  $.clearInterval 监听即刻咏唱
  ts.即刻咏唱 = A_TickCount - cd.技能施放补正