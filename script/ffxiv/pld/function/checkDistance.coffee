$distance = 'far'

checkDistance = ->

  unless $isTargeting
    $distance = 'far'
    return

  color = $.getColor 1479, 682

  if color == 0xD23A3A
    $distance = 'far'
    return
  
  $distance = 'near'