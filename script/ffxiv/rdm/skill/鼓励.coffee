ts.鼓励 = 0
cd.鼓励 = 120e3

鼓励 = ->

  unless A_TickCount - ts.鼓励 > cd.鼓励
    return false

  unless A_TickCount - ts.回刺 < cd.回刺
    return false

  $.press 'ctrl + 7'
  
  ts.鼓励 = A_TickCount - cd.鼓励 + cd.技能施放补正
  $.setInterval 监听鼓励, cd.技能施放判断间隔
  return true

监听鼓励 = ->
  unless isUsed '鼓励'
    return
  $.clearInterval 监听鼓励
  ts.鼓励 = A_TickCount - cd.技能施放补正