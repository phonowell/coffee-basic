$black = 0

checkBlack = ->

  [x, y] = $.findColor '#58483e', 1023, 811, 1170, 811, 10
  
  unless x
    $black = 100
    return
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.floor percent
  $black = percent