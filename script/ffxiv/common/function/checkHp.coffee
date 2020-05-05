$hp = 0

checkHp = ->
  
  [x, y] = $.findColor '#58483e', 21, 36, 168, 36, 10
  
  unless x
    $hp = 100
    return $hp
  
  percent = (x - 21) * 100 / (168 - 21)
  percent = Math.round percent
  $hp = percent
  return $hp