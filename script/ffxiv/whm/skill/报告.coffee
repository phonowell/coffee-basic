$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = makeReportMsg()
  msg = "#{msg}`n"
  msg = "#{msg}`nwhite: #{$white} / red: #{$red}"
  msg = "#{msg}`n"
  
  $ts.报告 = A_TickCount

  msg = makeReportMsg msg, [
    '神速咏唱'
    '法令'
    '无中生有'
    '神名'
    '全大赦'
    '即刻咏唱'
    '醒梦'
  ]
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3