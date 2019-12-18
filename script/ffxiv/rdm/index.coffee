# use admin
# include ../common/function
# include binding
# include function
# include skill

# ---

单体攻击 = ->

  if isChanting()
    return

  isA = hasStatus '连续咏唱'
  isB = hasStatus '即刻咏唱'
  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'

  if black > 85 and white > 85
    续斩()
    asr = 2
    return

  if 长单体 isA, isB, isBR, isWR
    asr = 2
    return

  if isMoving()
    续斩()
    asr = 2
    return

  短单体 isA, isB, isBR, isWR

  倍增()
  促进()
  即刻咏唱()
  能力技()

# ---

群体攻击 = ->

  if isChanting()
    return

  isA = hasStatus '连续咏唱'
  isB = hasStatus '即刻咏唱'
  if isA or isB
    散碎()
    asr = 2
    return

  if isMoving()
    续斩()
    asr = 2
    return

  if white >= black
    赤震雷()
  else
    赤烈风()

  倍增()
  即刻咏唱()
  能力技()

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

  unless distance == 'near'
    asr = 1
    短兵相接 true
    return

  if 回刺()
    asr = 2
    return

  if 交击斩()
    asr = 2
    鼓励()
    return

  if 连攻()
    asr = 2
    return

  if 赤神圣()
    asr = 2
    return

  if 焦热()
    asr = 2
    return
    
  能力技()

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