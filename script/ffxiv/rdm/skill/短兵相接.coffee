ts.短兵相接 = 0
cd.短兵相接 = 40e3

短兵相接 = (isForced = false) ->

  unless A_TickCount - ts.短兵相接 > cd.短兵相接
    return false

  distance = getDistance()
  unless distance == 'near' or isForced
    return false

  $.press 'alt + 4'

  ts.短兵相接 = A_TickCount - cd.短兵相接 + cd.技能施放补正
  $.setInterval 监听短兵相接, cd.技能施放判断间隔
  return true

监听短兵相接 = ->
  unless isUsed '短兵相接'
    return
  $.clearInterval 监听短兵相接
  ts.短兵相接 = A_TickCount - cd.技能施放补正