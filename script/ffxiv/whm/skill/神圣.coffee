$skill.神圣 = ->

  unless $level >= 45
    return
  
  $.press 'alt + equal'
  return true