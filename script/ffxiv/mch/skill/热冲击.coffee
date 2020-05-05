$skill.热冲击 = ->

  unless $level >= 35
    return

  unless $isOverheat
    return

  $.press 'alt + 9'

  $ts.虹吸弹 = $ts.虹吸弹 - 15e3
  $ts.弹射 = $ts.弹射 - 15e3
  return true