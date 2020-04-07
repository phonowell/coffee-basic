$gold = 0

checkGold = ->

  unless $level >= 35
    $gold = 0
    return

  [x, y] = $.findColor '#58483e', 1104, 806, 1247, 806, 10
  
  unless x
    $gold = 100
    return
  
  percent = (x - 1104) * 100 / (1247 - 1104)
  percent = Math.round percent / 5
  $gold = percent * 5