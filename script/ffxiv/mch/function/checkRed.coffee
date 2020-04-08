$red = 0

checkRed = ->

  [x, y] = $.findColor '#58483e', 1105, 760, 1248, 760, 10
  
  unless x
    $red = 100
    return
  
  percent = (x - 1105) * 100 / (1248 - 1105)
  percent = Math.round percent / 5
  $red = percent * 5