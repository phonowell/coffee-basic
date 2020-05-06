$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = makeReportMsg()
  msg = "#{msg}`n"
  
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