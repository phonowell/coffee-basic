$distance = 'far'

checkDistance = ->

  unless hasTarget
    $distance = 'far'
    return

  color = $.getColor 1875, 723

  if color == 0x1A1D1E
    $distance = 'near'
    return

  if color == 0x101312
    $distance = 'near'
    return

  if color == 0x101211
    $distance = 'near'
    return
  
  $distance = 'far'