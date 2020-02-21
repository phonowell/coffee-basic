calcCD = (ts, cd) ->
  result = cd - (A_TickCount - ts)
  
  unless result > 0
    return 0
  
  result = result / 1e3
  result = Math.round result
  return result

# ---

makeMsg = (msg, prefix, ts, cd) ->
  res = calcCD ts, cd
  unless res
    return msg
  return "#{msg}`n#{prefix}：#{res}s"

# ---

isReporting = true
tsReport = 0

report = ->

  unless isReporting
    return

  msg = "目标距离：#{distance}"
  msg = "#{msg}`n魔力：#{mp}%"
  msg = "#{msg}`n耗时：#{A_TickCount - tsReport}ms`n"
  
  tsReport = A_TickCount

  # msg = makeMsg msg, '短兵相接', 短兵相接时间戳, 短兵相接冷却
  # msg = makeMsg msg, '飞刺', 飞刺时间戳, 飞刺冷却
  # msg = makeMsg msg, '促进', 促进时间戳, 促进冷却
  # msg = makeMsg msg, '六分反击', 六分反击时间戳, 六分反击冷却
  # msg = makeMsg msg, '鼓励', 鼓励时间戳, 鼓励冷却
  # msg = makeMsg msg, '倍增', 倍增时间戳, 倍增冷却
  # msg = makeMsg msg, '交剑', 交剑时间戳, 交剑冷却
  # msg = makeMsg msg, '即刻咏唱', 即刻咏唱时间戳, 即刻咏唱冷却
  # msg = makeMsg msg, '醒梦', 醒梦时间戳, 醒梦冷却
  
  $.tip msg, 410, 640
  $.clearTimeout clearTip
  $.setTimeout clearTip, 5e3