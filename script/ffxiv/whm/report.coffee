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

isReporting = false
tsReport = 0

report = ->

  red = getRed()
  white = getWhite()

  unless isReporting
    return

  msg = "等级：#{level} / 魔力：#{mp}%"
  msg = "#{msg}`n白：#{white} / 红：#{red}"
  msg = "#{msg}`n耗时：#{A_TickCount - tsReport}ms`n"
  
  tsReport = A_TickCount

  msg = makeMsg msg, '神速咏唱', ts.神速咏唱, cd.神速咏唱
  msg = makeMsg msg, '法令', ts.法令, cd.法令
  msg = makeMsg msg, '无中生有', ts.无中生有, cd.无中生有
  msg = makeMsg msg, '神名', ts.神名, cd.神名
  msg = makeMsg msg, '全大赦', ts.全大赦, cd.全大赦
  msg = makeMsg msg, '即刻咏唱', ts.即刻咏唱, cd.即刻咏唱
  msg = makeMsg msg, '醒梦', ts.醒梦, cd.醒梦
  
  $.tip msg, 410, 640
  $.clearTimeout clearTip
  $.setTimeout clearTip, 5e3