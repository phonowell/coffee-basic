$skill.烧灼 = (isForced = false) ->

  if $isIM
    return

  unless isForced
    if hasStatusByTarget '烧灼' then return
  
  $.press 'alt + 3'
  return true