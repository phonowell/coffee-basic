$skill.医济 = ->

  unless $level >= 50
    return
  
  if hasStatus '医济'
    return
  
  $.press 'alt + 8'
  return true