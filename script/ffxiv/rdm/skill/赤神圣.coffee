赤神圣时间戳 = 0
赤神圣冷却 = 10e3

赤神圣 = ->

  unless A_TickCount - 赤神圣时间戳 > 赤神圣冷却
    return false

  unless A_TickCount - 连攻时间戳 < 15e3
    return false

  赤神圣施放()

  $.setInterval 监听赤神圣, 技能施放判断间隔
  return true

监听赤神圣 = ->
  isA = isUsed '赤核爆'
  isB = isUsed '赤神圣'
  unless isA or isB
    return
  $.clearInterval 监听赤神圣
  赤神圣时间戳 = A_TickCount - 技能施放时间戳补正

赤神圣施放 = ->

  if black - white > 9
    赤疾风()
    return

  if white - black > 9
    赤闪雷()
    return

  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'

  if isBR and isWR
    if black > white
      赤疾风()
    else
      赤闪雷()
    return

  if isBR
    赤疾风()
    return

  if isWR
    赤闪雷()
    return

  if black > white
    赤疾风()
  else
    赤闪雷()