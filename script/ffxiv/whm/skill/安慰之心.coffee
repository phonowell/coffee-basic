$skill.安慰之心 = ->

  unless $level >= 52
    return

  unless $white >= 1
    return

  unless 能力技冷却判断()
    return

  $.press 'ctrl + 2'
  return true