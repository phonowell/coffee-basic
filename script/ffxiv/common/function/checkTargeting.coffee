$isTargeting = false

checkTargeting = ->

  color = $.getColor 650, 65

  if color == 0xFF8888
    $hasTarget = true
    return

  if color == 0xFFC888
    $hasTarget = true
    return

  if color == 0xEBD788
    $hasTarget = true
    return

  if color == 0xFFB1FF
    $hasTarget = true
    return

  $hasTarget = false