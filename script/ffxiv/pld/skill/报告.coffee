$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = "等级：#{$level}"
  msg = "#{msg}`n忠义：#{$gold}"
  msg = "#{msg}`n目标距离：#{$distance}"
  msg = "#{msg}`n耗时：#{A_TickCount - $ts.报告}ms`n"
  
  $ts.报告 = A_TickCount

  msg = makeReportMsg msg, '战逃反应'
  msg = makeReportMsg msg, '预警'
  msg = makeReportMsg msg, '深奥之灵'
  msg = makeReportMsg msg, '厄运流转'
  msg = makeReportMsg msg, '铁壁'
  msg = makeReportMsg msg, '下踢'
  msg = makeReportMsg msg, '插言'
  msg = makeReportMsg msg, '雪仇'
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3