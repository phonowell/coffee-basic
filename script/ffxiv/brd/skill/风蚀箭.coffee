$skill.风蚀箭 = ->

  unless $level >= 30
    return

  if hasStatusByTarget '风蚀箭'
    return

  $.press 'alt + 7'
  return true