# include ../common/function

# ---

$distance = 'far'
getDistance = ->

  unless hasTarget
    return 'far'

  color = $.getColor 1479, 682

  if color == 0xD23A3A
    return 'far'
  
  return 'near'

# ---

$step = 0

resetStep = -> $step = 0