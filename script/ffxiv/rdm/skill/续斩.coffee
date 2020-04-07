$skill.续斩 = ->

  unless $level >= 76
    return

  unless $black >= 5 and $black < 80
    return

  unless $white >= 5 and $white < 80
    return
  
  $.press 'ctrl + minus'
  return true