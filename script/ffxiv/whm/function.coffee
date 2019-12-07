calcCD = (ts, cd) ->
  result = cd - (A_TickCount - ts)
  if result < 0
    result = 0
  result = result / 1e3
  result = Math.round result
  return result

# ---

red = 0
getRed = ->

  color = $.getColor 1075, 818
  unless color == 0xDEB673
    return 3

  color = $.getColor 1057, 818
  unless color == 0xDEB673
    return 2

  color = $.getColor 1039, 818
  unless color == 0xDEB673
    return 1

  return 0

# ---

white = 0
getWhite = ->
  
  color = $.getColor 1078, 790
  unless color == 0xD6B273
    return 3

  color = $.getColor 1058, 790
  unless color == 0xD6B273
    return 2

  color = $.getColor 1038, 790
  unless color == 0xD6B273
    return 1

  return 0

# ---

isReporting = true
tsReport = 0

report = ->

  unless isReporting
    return

  msg = "体力：#{hp}% / 魔力：#{mp}%"
  msg = "#{msg}`n白：#{white} / 红：#{red}"
  msg = "#{msg}`n耗时：#{A_TickCount - tsReport}ms`n"
  
  tsReport = A_TickCount

  res = calcCD 神速咏唱时间戳, 神速咏唱冷却
  if res
    msg = "#{msg}`n神速咏唱：#{res}s"

  res = calcCD 法令时间戳, 法令冷却
  if res
    msg = "#{msg}`n法令：#{res}s"

  res = calcCD 无中生有时间戳, 无中生有冷却
  if res
    msg = "#{msg}`n无中生有：#{res}s"

  res = calcCD 神名时间戳, 神名冷却
  if res
    msg = "#{msg}`n神名：#{res}s"

  res = calcCD 全大赦时间戳, 全大赦冷却
  if res
    msg = "#{msg}`n全大赦：#{res}s"

  res = calcCD 即刻咏唱时间戳, 即刻咏唱冷却
  if res
    msg = "#{msg}`n即刻咏唱：#{res}s"

  res = calcCD 醒梦时间戳, 醒梦冷却
  if res
    msg = "#{msg}`n醒梦：#{res}s"
  
  $.tip msg, 410, 640
  $.clearTimeout clearTip
  $.setTimeout clearTip, 5e3