$isReporting = true
$ts.报告 = 0

$skill.报告 = ->

  unless $isReporting
    return

  msg = makeReportMsg()
  msg = "#{msg}`n"
  msg = "#{msg}`ngold: #{$gold}"
  msg = "#{msg}`n"
  
  $ts.报告 = A_TickCount

  msg = makeReportMsg msg, [
    '战逃反应'
    '预警'
    '深奥之灵'
    '厄运流转'
    '沥血剑'
    '安魂祈祷'
    '调停'
    '铁壁'
    '下踢'
    '插言'
    '雪仇'
    '亲疏自行'
  ]
  
  $.tip msg, 410, 640
  clearTimeout clearTip
  setTimeout clearTip, 10e3