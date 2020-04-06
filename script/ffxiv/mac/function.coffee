# include ../common/function

# ---

$blue = 0
getBlue = ->

  [x, y] = $.findColor '#58483e', 1105, 806, 1248, 506, 10
  
  unless x
    return 100
  
  percent = (x - 1105) * 100 / (1248 - 1105)
  percent = Math.round percent / 5
  return percent * 5

# ---

$red = 0
getRed = ->

  [x, y] = $.findColor '#58483e', 1105, 760, 1248, 760, 10
  
  unless x
    return 100
  
  percent = (x - 1105) * 100 / (1248 - 1105)
  percent = Math.round percent / 5
  return percent * 5

# ---

$step = 0
resetStep = -> $step = 0