$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = "等级：#{$level}"
  msg = "#{msg}`n目标距离：#{$distance}"
  msg = "#{msg}`n耗时：#{A_TickCount - $ts.报告}ms`n"
  
  $ts.报告 = A_TickCount

  msg = makeReportMsg msg, '战逃反应'
  msg = makeReportMsg msg, '深奥之灵'
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3