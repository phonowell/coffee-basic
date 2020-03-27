$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = "等级：#{$level} / 魔力：#{$mp}%"
  msg = "#{msg}`n黑：#{$black} / 白：#{$white}"
  msg = "#{msg}`n赤火炎：#{$isBR} / 赤飞石：#{$isWR} / 连续咏唱：#{$isIM}"
  msg = "#{msg}`n咏唱：#{$isChanting} / 移动：#{$isMoving} / 目标距离：#{$distance}"
  msg = "#{msg}`n耗时：#{A_TickCount - $ts.报告}ms`n"
  
  $ts.报告 = A_TickCount

  msg = makeReportMsg msg, '短兵相接'
  msg = makeReportMsg msg, '飞刺'
  msg = makeReportMsg msg, '促进'
  msg = makeReportMsg msg, '六分反击'
  msg = makeReportMsg msg, '鼓励'
  msg = makeReportMsg msg, '倍增'
  msg = makeReportMsg msg, '交剑'
  msg = makeReportMsg msg, '即刻咏唱'
  msg = makeReportMsg msg, '醒梦'
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3