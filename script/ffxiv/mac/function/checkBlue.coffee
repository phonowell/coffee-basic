$blue = 0

checkBlue = ->

  [x, y] = $.findColor '#58483e', 1105, 806, 1248, 506, 10
  
  unless x
    $blue = 100
    return
  
  percent = (x - 1105) * 100 / (1248 - 1105)
  percent = Math.round percent / 5
  $blue = percent * 5