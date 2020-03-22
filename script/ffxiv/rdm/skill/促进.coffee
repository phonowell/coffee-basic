ts.促进 = 0
cd.促进 = 55e3

促进 = ->

  unless level >= 50
    return false

  unless A_TickCount - ts.促进 > cd.促进
    return false

  unless A_TickCount - ts.赤疾风 < 2e3
    return false

  unless A_TickCount - ts.回刺 > cd.魔三连
    return false

  if black > 70 or white > 70
    return false

  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'
  if isBR or isWR
    return false

  $.press 'ctrl + 3'
  
  ts.促进 = A_TickCount - cd.促进 + cd.技能施放补正
  $.setInterval 监听促进, cd.技能施放判断间隔
  return true

监听促进 = ->
  unless isUsed '促进'
    return
  $.clearInterval 监听促进
  ts.促进 = A_TickCount - cd.技能施放补正