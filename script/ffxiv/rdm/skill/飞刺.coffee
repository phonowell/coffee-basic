ts.飞刺 = 0
cd.飞刺 = 25e3

飞刺 = ->

  unless A_TickCount - ts.飞刺 > cd.飞刺
    return false
  
  $.press 'ctrl + 1'
  
  ts.飞刺 = A_TickCount - cd.飞刺 + cd.技能施放补正
  $.setInterval 监听飞刺, cd.技能施放判断间隔
  return true

监听飞刺 = ->
  unless isUsed '飞刺'
    return
  $.clearInterval 监听飞刺
  ts.飞刺 = A_TickCount - cd.技能施放补正