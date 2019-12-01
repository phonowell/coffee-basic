# use admin
# include ../common/function
# include skill
# include function
# include binding

# ---

短单体 = (isBR, isWR) ->

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

长单体 = (isBR, isWR) ->

  isA = hasStatus '连续咏唱'
  isB = hasStatus '即刻咏唱'

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

# ---

单体攻击 = ->

  if isChanting()
    return

  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'

  if 长单体 isBR, isWR
    asr = 2

  if isMoving()
    续斩()
    asr = 2

  短单体 isBR, isWR

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

  if isMoving()
    续斩()
    asr = 2

  if white >= black
    赤震雷()
  else
    赤烈风()

  即刻咏唱()
  能力技()

# ---

魔三连 = ->

  isA = hasStatus '连续咏唱'
  isB = hasStatus '即刻咏唱'
  if isA or isB
    攻击()
    asr = 2

  if 焦热()
    asr = 2

  if 赤神圣()
    asr = 2

  if 连攻()
    asr = 2
    交剑()
    短兵相接()

  if 交击斩()
    asr = 2
    鼓励()

  if 回刺()
    asr = 2
    短兵相接()
  
  能力技()