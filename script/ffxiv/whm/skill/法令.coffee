ts.法令 = 0
cd.法令 = 45e3

法令 = ->

  unless A_TickCount - ts.法令 > cd.法令
    return false

  $.press 'ctrl + 4'

  ts.法令 = A_TickCount - cd.法令 + cd.技能施放补正
  $.setInterval 监听法令, cd.技能施放判断间隔
  return true

监听法令 = ->
  unless isUsed '法令'
    return
  $.clearInterval 监听法令
  ts.法令 = A_TickCount - cd.技能施放补正