ts.交击斩 = 0
cd.交击斩 = 10e3

交击斩 = ->

  unless A_TickCount - ts.交击斩 > cd.交击斩
    return false

  unless A_TickCount - ts.回刺 < cd.魔三连
    return false

  unless black >= 50 and white >= 50
    return false

  $.press 'alt + minus'
  
  $.setInterval 监听交击斩, cd.技能施放判断间隔
  return true

监听交击斩 = ->
  unless isUsed '魔交击斩'
    return
  $.clearInterval 监听交击斩
  ts.交击斩 = A_TickCount - cd.技能施放补正