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

  red = getRed()
  white = getWhite()

  unless isReporting
    return

  msg = "魔力：#{mp}% / 白：#{white} / 红：#{red}"
  msg = "#{msg}`n耗时：#{A_TickCount - tsReport}ms`n"
  
  tsReport = A_TickCount

  msg = makeMsg msg, '神速咏唱', 神速咏唱时间戳, 神速咏唱冷却
  msg = makeMsg msg, '法令', 法令时间戳, 法令冷却
  msg = makeMsg msg, '无中生有', 无中生有时间戳, 无中生有冷却
  msg = makeMsg msg, '神名', 神名时间戳, 神名冷却
  msg = makeMsg msg, '全大赦', 全大赦时间戳, 全大赦冷却
  msg = makeMsg msg, '即刻咏唱', 即刻咏唱时间戳, 即刻咏唱冷却
  msg = makeMsg msg, '醒梦', 醒梦时间戳, 醒梦冷却
  
  $.tip msg, 410, 640
  $.clearTimeout clearTip
  $.setTimeout clearTip, 5e3