$white = 0

checkWhite = ->

  [x, y] = $.findColor '#58483e', 1023, 798, 1170, 798, 10
  
  unless x
    $white = 100
    return
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.floor percent
  $white = percent