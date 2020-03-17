ts.交剑 = 0
cd.交剑 = 35e3

交剑 = ->

  unless A_TickCount - ts.交剑 > cd.交剑
    return false

  distance = getDistance()
  unless distance == 'near'
    return false

  $.press 'ctrl + 0'
  
  ts.交剑 = A_TickCount - cd.交剑 + cd.技能施放补正
  $.setInterval 监听交剑, cd.技能施放判断间隔
  return true

监听交剑 = ->
  unless isUsed '交剑'
    return
  $.clearInterval 监听交剑
  ts.交剑 = A_TickCount - cd.技能施放补正