$isTargeting = false
$ts.targeting = 0

checkTargeting = ->

  color = $.getColor 650, 65

  if color == 0xFF8888
    return setTargeting()

  if color == 0xFFC888
    return setTargeting()

  if color == 0xEBD788
    return setTargeting()

  if color == 0xFFB1FF
    return setTargeting()

  $isTargeting = false
  return $isTargeting

setTargeting = ->
  $isTargeting = true
  $ts.targeting = A_TickCount
  return $isTargeting