$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = "等级：#{$level}"
  msg = "#{msg}`n耗时：#{A_TickCount - $ts.报告}ms`n"
  
  $ts.报告 = A_TickCount

  msg = makeReportMsg msg, [
    '猛者强击'
    '失血箭'
    '纷乱箭'
    '贤者的叙事谣'
    '伤腿'
    '伤足'
  ]
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3