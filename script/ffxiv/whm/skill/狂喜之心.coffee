$skill.狂喜之心 = ->

  unless $level >= 76
    return

  unless $white >= 1
    return

  unless 能力技冷却判断()
    return

  $.press 'ctrl + 0'
  return true