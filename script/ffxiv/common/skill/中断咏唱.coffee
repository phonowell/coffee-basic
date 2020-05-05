$skill.中断咏唱 = ->
  unless $isChanting
    return true
  $.press 'space'
  return true