$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = "等级：#{$level}"
  msg = "#{msg}`n电：#{$blue} / 热：#{$red}"
  msg = "#{msg}`n耗时：#{A_TickCount - $ts.报告}ms`n"
  
  $ts.报告 = A_TickCount

  msg = makeReportMsg msg, '热弹'
  msg = makeReportMsg msg, '整备'
  msg = makeReportMsg msg, '虹吸弹'
  msg = makeReportMsg msg, '超荷'
  msg = makeReportMsg msg, '车式浮空炮塔'
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3