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

$gold = 0
getGold = ->

  unless $level >= 35
    return 0

  [x, y] = $.findColor '#58483e', 1104, 806, 1247, 806, 10
  
  unless x
    return 100
  
  percent = (x - 1104) * 100 / (1247 - 1104)
  percent = Math.round percent / 5
  return percent * 5

# ---

$step = 0
resetStep = -> $step = 0