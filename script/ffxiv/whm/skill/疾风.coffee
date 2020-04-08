$skill.疾风 = (isForced = false) ->

  unless isForced

    if $level >= 72
      if hasStatusByTarget '天辉' then return
    else if $level >= 46
      if hasStatusByTarget '烈风' then return
    else
      if hasStatusByTarget '疾风' then return
  
  $.press 'alt + 3'
  return true