$isNear = false

checkNear = ->

  unless $isTargeting
    $isNear = false
    return $isNear

  color = $.getColor 1803, 764

  if color == 0xD23A3A
    $isNear = false
    return $isNear
  
  $isNear = true
  return $isNear