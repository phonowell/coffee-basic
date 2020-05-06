$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = makeReportMsg()
  msg = "#{msg}`n"
  
  $ts.报告 = A_TickCount

  msg = makeReportMsg msg, [
    '猛者强击'
    '毒咬箭'
    '失血箭'
    '风蚀箭'
    '纷乱箭'
    '贤者的叙事谣'
    '伤腿'
    '伤足'
  ]
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3