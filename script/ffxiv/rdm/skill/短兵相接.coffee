短兵相接时间戳 = 0
短兵相接冷却 = 40e3

短兵相接 = (isForced = false) ->

  unless A_TickCount - 短兵相接时间戳 > 短兵相接冷却
    return false

  distance = getDistance()
  unless distance == 'near' or isForced
    return false

  $.press 'alt + 4'

  短兵相接时间戳 = A_TickCount - 短兵相接冷却 + 技能施放时间戳补正
  $.setInterval 监听短兵相接, 技能施放判断间隔
  return true

监听短兵相接 = ->
  unless isUsed '短兵相接'
    return
  $.clearInterval 监听短兵相接
  短兵相接时间戳 = A_TickCount - 技能施放时间戳补正