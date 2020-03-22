ts.赤神圣 = 0
cd.赤神圣 = 10e3

赤神圣 = ->

  unless level >= 70
    return false

  unless A_TickCount - ts.赤神圣 > cd.赤神圣
    return false

  unless A_TickCount - ts.连攻 < 15e3
    return false

  赤神圣施放()

  $.setInterval 监听赤神圣, cd.技能施放判断间隔
  return true

监听赤神圣 = ->
  isA = isUsed '赤核爆'
  isB = isUsed '赤神圣'
  unless isA or isB
    return
  $.clearInterval 监听赤神圣
  ts.赤神圣 = A_TickCount - cd.技能施放补正

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