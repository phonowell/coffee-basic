$skill.重力 = ->

  unless $level >= 45
    return
  
  $.press 'ctrl + 3'
  return true