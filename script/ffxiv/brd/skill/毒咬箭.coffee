$skill.毒咬箭 = ->

  if hasStatusByTarget '毒咬箭'
    return

  $.press 'alt + 4'
  return true