$isTargeting = false

checkTargeting = ->

  color = $.getColor 650, 65

  if color == 0xFF8888
    $isTargeting = true
    return

  if color == 0xFFC888
    $isTargeting = true
    return

  if color == 0xEBD788
    $isTargeting = true
    return

  if color == 0xFFB1FF
    $isTargeting = true
    return

  $isTargeting = false