$skill.烧灼 = (isForced = false) ->

  if $isIM
    return

  unless isForced
    if $level >= 46
      if hasStatusByTarget '炽灼' then return
    else
      if hasStatusByTarget '烧灼' then return
  
  $.press 'alt + 3'
  return true