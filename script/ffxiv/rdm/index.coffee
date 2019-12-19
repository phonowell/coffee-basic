# use admin
# include ../common/function
# include binding
# include function
# include report
# include skill

# ---

单体攻击 = ->

  if isChanting()
    return

  isA = hasStatus '连续咏唱'
  isB = hasStatus '即刻咏唱'
  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'

  if 长单体 isA, isB, isBR, isWR
    能力技()
    return

  if isMoving()
    续斩()
    能力技()
    return

  短单体 isA, isB, isBR, isWR

# ---

群体攻击 = ->

  if isChanting()
    return

  isA = hasStatus '连续咏唱'
  isB = hasStatus '即刻咏唱'
  if isA or isB
    散碎()
    能力技()
    return

  if isMoving()
    续斩()
    能力技()
    return

  if white >= black
    赤震雷()
  else
    赤烈风()

# ---

魔三连 = ->

  isValid = true

  if hasStatus '连续咏唱'
    isValid = false
  if hasStatus '即刻咏唱'
    isValid = false

  unless isValid
    单体攻击()
    return

  if 回刺()
    能力技()
    return

  if 交击斩()
    能力技()
    return

  if 连攻()
    能力技()
    return

  if 赤神圣()
    能力技()
    return

  if 焦热()
    能力技()
    return

# ---

短单体 = (isA, isB, isBR, isWR) ->

  if isA or isB
    return

  if black - white > 21
    if isWR
      赤飞石()
    else
      摇荡()
    return

  if white - black > 21
    if isBR
      赤火炎()
    else
      摇荡()
    return

  if isWR and isBR
    if black > white
      赤飞石()
    else
      赤火炎()
    return

  if isWR
    赤飞石()
    return

  if isBR
    赤火炎()
    return

  摇荡()

# ---

长单体 = (isA, isB, isBR, isWR) ->

  unless isA or isB
    return false

  if black - white > 19
    赤疾风()
    return true

  if white - black > 19
    赤闪雷()
    return true
  
  if isWR
    赤闪雷()
    return true
  
  if isBR
    赤疾风()
    return true

  if white >= black
    赤闪雷()
  else
    赤疾风()

  return true