$skill.再生 = ->

  unless $level >= 35
    return
  
  if hasStatusByTarget '再生'
    return

  unless 能力技冷却判断()
    return
  
  $.press 'alt + 0'
  return true