$skill.神圣 = ->

  unless $level >= 45
    return
  
  $.press 'ctrl + equal'
  return true