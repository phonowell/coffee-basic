$isNear = false

checkNear = ->

  unless $isTargeting
    $isNear = false
    return $isNear

  color = $.getColor 1479, 682

  if color == 0xD23A3A
    $isNear = false
    return $isNear
  
  $isNear = true
  return $isNear