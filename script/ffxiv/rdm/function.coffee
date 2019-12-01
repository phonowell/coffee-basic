getBlack = ->
  [x, y] = $.findColor '#56463c', 1027, 810, 1166, 810
  
  unless x
    return 100
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.round percent
  return percent - 1

getWhite = ->
  [x, y] = $.findColor '#2e1e14', 1027, 801, 1166, 801
  
  unless x
    return 100
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.round percent
  return percent - 1