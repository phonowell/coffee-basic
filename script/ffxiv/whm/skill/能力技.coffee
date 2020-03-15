能力技时间戳 = 0
能力技冷却 = 300

能力技冷却判断 = ->

  unless A_TickCount - 能力技时间戳 > 能力技冷却
    return false

  能力技时间戳 = A_TickCount
  return true