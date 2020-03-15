black = 0
getBlack = ->
  [x, y] = $.findColor '#58483e', 1023, 811, 1170, 811, 10
  
  unless x
    return 100
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.floor percent
  return percent

# ---

distance = 'far'
getDistance = ->

  unless hasTarget
    return 'far'

  color = $.getColor 1875, 723

  if color == 0x872424
    return 'far'

  if color == 0x8C1E1E
    return 'far'
  
  return 'near'

# ---

white = 0
getWhite = ->
  [x, y] = $.findColor '#58483e', 1023, 798, 1170, 798, 10
  
  unless x
    return 100
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.floor percent
  return percent