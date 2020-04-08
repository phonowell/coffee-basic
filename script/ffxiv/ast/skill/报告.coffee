$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = "等级：#{$level} / 魔力：#{$mp}%"
  msg = "#{msg}`n咏唱：#{$isChanting} / 移动：#{$isMoving}"
  msg = "#{msg}`n耗时：#{A_TickCount - $ts.报告}ms`n"
  
  $ts.报告 = A_TickCount

  msg = makeReportMsg msg, [
    '光速'
    '先天禀赋'
    '抽卡'
    '即刻咏唱'
    '醒梦'
  ]
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3