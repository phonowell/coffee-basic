makeReportMsg = (msg = false, list = false) ->

  unless msg
    msg = "Lv.#{$level} / #{$trigger} / #{A_TickCount - $ts.报告} ms"
    msg = "#{msg}`nhp: #{$hp} / mp: #{$mp}"
    msg = "#{msg}`ntargeting: #{$isTargeting} / near: #{$isNear}"
    msg = "#{msg}`nmoving: #{$isMoving} / chanting: #{$isChanting}"
    return msg
  
  for name in list
    result = calcCd name
    unless result > 1
      continue
    msg = "#{msg}`n#{name}: #{result} s"
  
  return msg