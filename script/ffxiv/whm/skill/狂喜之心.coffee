$skill.狂喜之心 = ->

  unless $level >= 76
    return

  unless $white >= 1
    return

  unless $red < 3
    return

  unless 能力技冷却判断()
    return

  $.press 'alt + 0'
  return true