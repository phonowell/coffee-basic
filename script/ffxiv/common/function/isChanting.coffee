$isChanting = false
isChanting = ->
  
  if $isMoving
    return false
  
  color = $.getColor 1130, 865
  return color == 0x2B1B13