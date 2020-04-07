hasTarget = false
isTargeting = ->

  color = $.getColor 650, 65

  if color == 0xFF8888
    return true

  if color == 0xFFC888
    return true

  if color == 0xEBD788
    return true

  if color == 0xFFB1FF
    return true

  return false