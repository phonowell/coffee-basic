$mp = 0

checkMp = ->

  [x, y] = $.findColor '#58483e', 181, 36, 328, 36, 10
  
  unless x
    $mp = 100
    return
  
  percent = (x - 181) * 100 / (328 - 181)
  percent = Math.round percent
  $mp = precent
  return