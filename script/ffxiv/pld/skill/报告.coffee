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

  msg = makeReportMsg msg, [
    '战逃反应'
    '预警'
    '深奥之灵'
    '厄运流转'
    '铁壁'
    '下踢'
    '插言'
    '雪仇'
  ]
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3