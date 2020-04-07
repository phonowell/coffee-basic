$skill.划圆斩 = ->

  unless $level >= 52
    return

  unless $black >= 20 and $white >= 20
    return

  checkDistance()
  unless $distance == 'near'
    use '短兵相接', true
    return

  $.press 'ctrl + 4'
  return true