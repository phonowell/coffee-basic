$skill.圣灵 = ->

  unless $level >= 64
    return

  unless $mp >= 20
    return

  unless hasStatus '安魂祈祷'
    return

  $.press 'ctrl + 8'

  $step = 0
  return true