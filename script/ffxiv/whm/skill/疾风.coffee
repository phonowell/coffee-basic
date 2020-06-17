$skill.疾风 = ->

  unless $isMoving

    if $level >= 72
      if hasStatusByTarget '天辉'
        return
    else if $level >= 46
      if hasStatusByTarget '烈风'
        return
    else
      if hasStatusByTarget '疾风'
        return
  
  $.press 'ctrl + 3'
  return true