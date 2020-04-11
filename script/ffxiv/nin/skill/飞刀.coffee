$skill.飞刀 = ->

  unless $level >= 15
    return

  $.press 'alt + 5'

  $step = 0
  return true