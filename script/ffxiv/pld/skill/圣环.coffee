$skill.圣环 = ->

  unless $level >= 72
    return

  unless $mp >= 20
    return

  unless hasStatus '安魂祈祷'
    return

  $.press 'alt + minus'

  $step = 0
  return true