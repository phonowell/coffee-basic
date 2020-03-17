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

  # msg = makeMsg msg, '短兵相接', ts.短兵相接, cd.短兵相接
  # msg = makeMsg msg, '飞刺', ts.飞刺, cd.飞刺
  # msg = makeMsg msg, '促进', ts.促进, cd.促进
  # msg = makeMsg msg, '六分反击', ts.六分反击, cd.六分反击
  # msg = makeMsg msg, '鼓励', ts.鼓励, cd.鼓励
  # msg = makeMsg msg, '倍增', ts.倍增, cd.倍增
  # msg = makeMsg msg, '交剑', ts.交剑, cd.交剑
  # msg = makeMsg msg, '即刻咏唱', ts.即刻咏唱, cd.即刻咏唱
  # msg = makeMsg msg, '醒梦', ts.醒梦, cd.醒梦
  
  $.tip msg, 410, 640
  $.clearTimeout clearTip
  $.setTimeout clearTip, 5e3