calcCD = (ts, cd) ->
  result = cd - (A_TickCount - ts)
  if result < 0
    result = 0
  result = result / 1e3
  result = Math.round result
  return result

black = 0
getBlack = ->
  [x, y] = $.findColor '#58483e', 1023, 811, 1170, 811, 10
  
  unless x
    return 100
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.floor percent
  return percent

white = 0
getWhite = ->
  [x, y] = $.findColor '#58483e', 1023, 798, 1170, 798, 10
  
  unless x
    return 100
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.floor percent
  return percent

# ---

isReporting = true
tsReport = 0

report = ->

  unless isReporting
    return

  msg = "体力：#{hp}% / 魔力：#{mp}%"
  msg = "#{msg}`n黑：#{black} / 白：#{white}"
  msg = "#{msg}`n自动索敌：#{isAutoTargeting}"
  msg = "#{msg}`n耗时：#{A_TickCount - tsReport}ms`n"
  
  tsReport = A_TickCount

  res = calcCD 短兵相接时间戳, 短兵相接冷却
  if res
    msg = "#{msg}`n短兵相接：#{res}s"
  
  res = calcCD 飞刺时间戳, 飞刺冷却
  if res
    msg = "#{msg}`n飞刺：#{res}s"

  res = calcCD 促进时间戳, 促进冷却
  if res
    msg = "#{msg}`n促进：#{res}s"

  res = calcCD 六分反击时间戳, 六分反击冷却
  if res
    msg = "#{msg}`n六分反击：#{res}s"

  res = calcCD 鼓励时间戳, 鼓励冷却
  if res
    msg = "#{msg}`n鼓励：#{res}s"

  res = calcCD 倍增时间戳, 倍增冷却
  if res
    msg = "#{msg}`n倍增：#{res}s"

  res = calcCD 交剑时间戳, 交剑冷却
  if res
    msg = "#{msg}`n交剑：#{res}s"

  res = calcCD 即刻咏唱时间戳, 即刻咏唱冷却
  if res
    msg = "#{msg}`n即刻咏唱：#{res}s"

  res = calcCD 醒梦时间戳, 醒梦冷却
  if res
    msg = "#{msg}`n醒梦：#{res}s"
  
  $.tip msg, 410, 640
  $.clearTimeout clearTip
  $.setTimeout clearTip, 5e3