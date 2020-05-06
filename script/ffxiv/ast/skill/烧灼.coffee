$skill.烧灼 = ->

  unless $isMoving

    if $level >= 46
      if hasStatusByTarget '炽灼'
        return
    else
      if hasStatusByTarget '烧灼'
        return
  
  $.press 'alt + 3'
  return true