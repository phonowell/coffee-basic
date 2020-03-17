ts.六分反击 = 0
cd.六分反击 = 35e3

六分反击 = ->

  unless A_TickCount - ts.六分反击 > cd.六分反击
    return false

  $.press 'ctrl + 6'
  
  ts.六分反击 = A_TickCount - cd.六分反击 + cd.技能施放补正
  $.setInterval 监听六分反击, cd.技能施放判断间隔
  return true

监听六分反击 = ->
  unless isUsed '六分反击'
    return
  $.clearInterval 监听六分反击
  ts.六分反击 = A_TickCount - cd.技能施放补正