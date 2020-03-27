isReporting = false
tsReport = 0

report = ->

  black = getBlack()
  white = getWhite()

  unless isReporting
    return

  msg = "等级：#{level} / 魔力：#{mp}%"
  msg = "#{msg}`n黑：#{black} / 白：#{white}"
  msg = "#{msg}`n目标距离：#{distance}"
  msg = "#{msg}`n耗时：#{A_TickCount - tsReport}ms`n"
  
  tsReport = A_TickCount

  msg = makeReportMsg msg, '短兵相接'
  msg = makeReportMsg msg, '飞刺'
  msg = makeReportMsg msg, '促进'
  msg = makeReportMsg msg, '六分反击'
  msg = makeReportMsg msg, '鼓励'
  msg = makeReportMsg msg, '倍增'
  msg = makeReportMsg msg, '交剑'
  msg = makeReportMsg msg, '即刻咏唱'
  msg = makeReportMsg msg, '醒梦'
  
  $.tip msg, 410, 640
  $.clearTimeout clearTip
  $.setTimeout clearTip, 5e3