$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = makeReportMsg()
  msg = "#{msg}`n"
  msg = "#{msg}`nred: #{$red} / blue: #{$blue} / overheat: #{$isOverheat}"
  msg = "#{msg}`n"
  
  $ts.报告 = A_TickCount

  msg = makeReportMsg msg, [
    '热弹'
    '整备'
    '虹吸弹'
    '超荷'
    '野火'
    '弹射'
    '伤腿'
    '伤足'
  ]
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3