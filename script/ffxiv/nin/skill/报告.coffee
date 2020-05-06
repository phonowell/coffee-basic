$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = makeReportMsg()
  msg = "#{msg}`n"
  
  $ts.报告 = A_TickCount

  msg = makeReportMsg msg, [
    '残影'
    '夺取'
    '影牙'
    '内丹'
    '扫腿'
    '浴血'
    '牵制'
  ]
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3