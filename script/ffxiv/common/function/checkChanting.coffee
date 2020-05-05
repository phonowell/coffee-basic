$isChanting = false

checkChanting = ->
  
  if $isMoving
    $isChanting = false
    return $isChanting
  
  color = $.getColor 1130, 865
  $isChanting = color == 0x2B1B13
  return isChanting