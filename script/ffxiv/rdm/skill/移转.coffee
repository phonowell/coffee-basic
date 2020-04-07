$skill.移转 = ->

  unless $level >= 40
    return

  $.press 'alt + equal'
  return true