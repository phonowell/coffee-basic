calcCD = (ts, cd) ->
  result = cd - (A_TickCount - ts)
  if result < 0
    result = 0
  result = result / 1e3
  result = Math.round result
  return result

# ---

element = false
checkElement = ->
  color = $.getColor 1030, 815
  if color == 0xFFABA7
    element = 'fire'
    return
  if color == 0x93C9FF
    element = 'ice'
    return
  element = false

# ---

isMpLacking = false
checkMp = ->

  mp = getMp()

  if mp < 30 and isMpLacking == false
    isMpLacking = true
  else if mp > 70 and isMpLacking == true
    isMpLacking = false

# ---

isReporting = true
tsReport = 0

# ---

report = ->

  unless isReporting
    return

  msg = "体力：#{hp}% / 魔力：#{mp}%"
  msg = "#{msg}`n元素状态：#{element}"
  msg = "#{msg}`n使用Dot：#{isDotEnabled}"
  msg = "#{msg}`n耗时：#{A_TickCount - tsReport}ms`n"
  
  tsReport = A_TickCount

  res = calcCD 即刻咏唱时间戳, 即刻咏唱冷却
  if res
    msg = "#{msg}`n即刻咏唱：#{res}s"
  
  $.tip msg, 410, 640
  $.clearTimeout clearTip
  $.setTimeout clearTip, 5e3