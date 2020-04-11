$skill.忍术 = ->

  unless $level >= 30
    return

  $.press 'alt + equal'
  return true