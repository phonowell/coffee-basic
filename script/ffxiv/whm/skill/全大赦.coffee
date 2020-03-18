ts.全大赦 = 0
cd.全大赦 = 60e3

全大赦 = ->

  unless A_TickCount - ts.全大赦 > cd.全大赦
    return false

  unless 能力技冷却判断()
    return false

  $.press 'ctrl + 8'

  ts.全大赦 = A_TickCount - cd.全大赦 + cd.技能施放补正
  $.setInterval 监听全大赦, cd.技能施放判断间隔
  return true

监听全大赦 = ->
  unless isUsed '全大赦'
    return
  $.clearInterval 监听全大赦
  ts.全大赦 = A_TickCount - cd.技能施放补正