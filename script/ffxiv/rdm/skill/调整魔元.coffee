$skill.调整魔元 = ->
  
  unless $level >= 60
    return
  
  unless A_TickCount - $ts.倍增 > $cd.倍增 - 2e3
    return
  
  unless $black >= 60 and $white >= 60
    return
  
  $distance = getDistance()
  unless $distance == 'near'
    return
  
  use '划圆斩'
  return true