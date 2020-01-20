技能施放判断间隔 = 100
技能施放时间戳补正 = 1500
魔三连冷却 = 15e3

# ---

回刺时间戳 = 0
回刺冷却 = 10e3

回刺 = ->

  unless A_TickCount - 回刺时间戳 > 回刺冷却
    return false

  unless black >= 80 and white >= 80
    return false

  中断咏唱()

  distance = getDistance()
  unless distance == 'near'
    短兵相接 true
    return false

  $.press 'alt + 1'

  $.setInterval 监听回刺, 技能施放判断间隔
  return true

监听回刺 = ->
  unless isUsed '魔回刺'
    return
  $.clearInterval 监听回刺
  回刺时间戳 = A_TickCount - 技能施放时间戳补正

# ---

摇荡 = -> $.press 'alt + 2'

# ---

赤闪雷 = ->
  $.press 'alt + 3'
  赤疾风时间戳 = A_TickCount

# ---

短兵相接时间戳 = 0
短兵相接冷却 = 40e3

短兵相接 = (isForced = false) ->

  unless A_TickCount - 短兵相接时间戳 > 短兵相接冷却
    return false

  distance = getDistance()
  unless distance == 'near' or isForced
    return false

  $.press 'alt + 4'

  短兵相接时间戳 = A_TickCount - 短兵相接冷却 + 技能施放时间戳补正
  $.setInterval 监听短兵相接, 技能施放判断间隔
  return true

监听短兵相接 = ->
  unless isUsed '短兵相接'
    return
  $.clearInterval 监听短兵相接
  短兵相接时间戳 = A_TickCount - 技能施放时间戳补正

# ---

赤疾风时间戳 = 0
赤疾风 = ->
  $.press 'alt + 5'
  赤疾风时间戳 = A_TickCount

# ---

散碎 = -> $.press 'alt + 6'
赤震雷 = -> $.press 'alt + 7'
赤烈风 = -> $.press 'alt + 8'
赤火炎 = -> $.press 'alt + 9'
赤飞石 = -> $.press 'alt + 0'

# ---

交击斩时间戳 = 0
交击斩冷却 = 10e3

交击斩 = ->

  unless A_TickCount - 交击斩时间戳 > 交击斩冷却
    return false

  unless A_TickCount - 回刺时间戳 < 魔三连冷却
    return false

  unless black >= 50 and white >= 50
    return false

  $.press 'alt + minus'
  
  $.setInterval 监听交击斩, 技能施放判断间隔
  return true

监听交击斩 = ->
  unless isUsed '魔交击斩'
    return
  $.clearInterval 监听交击斩
  交击斩时间戳 = A_TickCount - 技能施放时间戳补正

# ---

移转 = -> $.press 'alt + equal'

# ---

飞刺时间戳 = 0
飞刺冷却 = 25e3

飞刺 = ->

  unless A_TickCount - 飞刺时间戳 > 飞刺冷却
    return false
  
  $.press 'ctrl + 1'
  
  飞刺时间戳 = A_TickCount - 飞刺冷却 + 技能施放时间戳补正
  $.setInterval 监听飞刺, 技能施放判断间隔
  return true

监听飞刺 = ->
  unless isUsed '飞刺'
    return
  $.clearInterval 监听飞刺
  飞刺时间戳 = A_TickCount - 技能施放时间戳补正

# ---

连攻时间戳 = 0
连攻冷却 = 10e3

连攻 = ->

  unless A_TickCount - 连攻时间戳 > 连攻冷却
    return false

  unless A_TickCount - 交击斩时间戳 < 魔三连冷却
    return false

  unless black >= 25 and white >= 25
    return false

  $.press 'ctrl + 2'
  
  $.setInterval 监听连攻, 技能施放判断间隔
  return true

监听连攻 = ->
  unless isUsed '魔连攻'
    return
  $.clearInterval 监听连攻
  连攻时间戳 = A_TickCount - 技能施放时间戳补正

# ---

促进时间戳 = 0
促进冷却 = 35e3

促进 = ->

  unless A_TickCount - 促进时间戳 > 促进冷却
    return false

  unless A_TickCount - 赤疾风时间戳 < 2e3
    return false

  unless A_TickCount - 回刺时间戳 > 魔三连冷却
    return false

  if black > 70 or white > 70
    return false

  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'
  if isBR or isWR
    return false

  $.press 'ctrl + 3'
  
  促进时间戳 = A_TickCount - 促进冷却 + 技能施放时间戳补正
  $.setInterval 监听促进, 技能施放判断间隔
  return true

监听促进 = ->
  unless hasStatus '促进'
    return
  $.clearInterval 监听促进
  促进时间戳 = A_TickCount - 技能施放时间戳补正

# ---

划圆斩 = ->

  unless black >= 20 and white >= 20
    return false

  distance = getDistance()
  unless distance == 'near'
    短兵相接 true
    return false

  $.press 'ctrl + 4'
  return true

# ---

赤治疗 = -> $.press 'ctrl + 5'

# ---

六分反击时间戳 = 0
六分反击冷却 = 35e3

六分反击 = ->

  unless A_TickCount - 六分反击时间戳 > 六分反击冷却
    return false

  $.press 'ctrl + 6'
  
  六分反击时间戳 = A_TickCount - 六分反击冷却 + 技能施放时间戳补正
  $.setInterval 监听六分反击, 技能施放判断间隔
  return true

监听六分反击 = ->
  unless isUsed '六分反击'
    return
  $.clearInterval 监听六分反击
  六分反击时间戳 = A_TickCount - 技能施放时间戳补正

# ---

鼓励时间戳 = 0
鼓励冷却 = 120e3

鼓励 = ->

  unless A_TickCount - 鼓励时间戳 > 鼓励冷却
    return false

  unless A_TickCount - 回刺时间戳 < 回刺冷却
    return false

  $.press 'ctrl + 7'
  
  鼓励时间戳 = A_TickCount - 鼓励冷却 + 技能施放时间戳补正
  $.setInterval 监听鼓励, 技能施放判断间隔
  return true

监听鼓励 = ->
  unless isUsed '鼓励'
    return
  $.clearInterval 监听鼓励
  鼓励时间戳 = A_TickCount - 技能施放时间戳补正

# ---

倍增时间戳 = 0
倍增冷却 = 110e3

倍增 = ->

  unless A_TickCount - 倍增时间戳 > 倍增冷却
    return false

  if A_TickCount - 回刺时间戳 < 魔三连冷却
    return false

  unless black >= 40 and black <= 70
    return false

  unless white >= 40 and white <= 70
    return false

  $.press 'ctrl + 8'
  
  倍增时间戳 = A_TickCount - 倍增冷却 + 技能施放时间戳补正
  $.setInterval 监听倍增, 技能施放判断间隔
  return true

监听倍增 = ->
  unless isUsed '倍增'
    return
  $.clearInterval 监听倍增
  倍增时间戳 = A_TickCount - 技能施放时间戳补正
  短兵相接时间戳 = 0
  移转时间戳 = 0
  交剑时间戳 = 0

# ---

赤复活 = -> $.press 'ctrl + 9'

# ---

交剑时间戳 = 0
交剑冷却 = 35e3

交剑 = ->

  unless A_TickCount - 交剑时间戳 > 交剑冷却
    return false

  distance = getDistance()
  unless distance == 'near'
    return false

  $.press 'ctrl + 0'
  
  交剑时间戳 = A_TickCount - 交剑冷却 + 技能施放时间戳补正
  $.setInterval 监听交剑, 技能施放判断间隔
  return true

监听交剑 = ->
  unless isUsed '交剑'
    return
  $.clearInterval 监听交剑
  交剑时间戳 = A_TickCount - 技能施放时间戳补正

# ---

续斩 = -> $.press 'ctrl + minus'
昏乱 = -> $.press 'ctrl + equal'

# ---

即刻咏唱时间戳 = 0
即刻咏唱冷却 = 60e3

即刻咏唱 = ->

  unless A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却
    return false

  unless A_TickCount - 回刺时间戳 > 回刺冷却
    return false

  if black > 70 or white > 70
    return false

  if hasStatus '连续咏唱'
    return false

  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'
  if isBR and isWR
    return

  $.press 'shift + 1'
  
  即刻咏唱时间戳 = A_TickCount - 即刻咏唱冷却 + 技能施放时间戳补正
  $.setInterval 监听即刻咏唱, 技能施放判断间隔
  return true

监听即刻咏唱 = ->
  unless hasStatus '即刻咏唱'
    return
  $.clearInterval 监听即刻咏唱
  即刻咏唱时间戳 = A_TickCount - 技能施放时间戳补正

# ---

醒梦时间戳 = 0
醒梦冷却 = 60e3

醒梦 = ->

  unless A_TickCount - 醒梦时间戳 > 醒梦冷却
    return false

  mp = getMp()
  if mp > 50
    return false

  $.press 'shift + 2'
  
  醒梦时间戳 = A_TickCount - 醒梦冷却 + 技能施放时间戳补正
  $.setInterval 监听醒梦, 技能施放判断间隔
  return true

监听醒梦 = ->
  unless hasStatus '醒梦'
    return
  $.clearInterval 监听醒梦
  醒梦时间戳 = A_TickCount - 技能施放时间戳补正

# ---

沉稳咏唱 = -> $.press 'shift + 3'
清空信息 = -> $.press 'shift + equal'
  
# ---

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

# ---

焦热时间戳 = 0
焦热冷却 = 10e3

焦热 = ->

  unless A_TickCount - 焦热时间戳 > 焦热冷却
    $.beep()
    return false

  unless A_TickCount - 赤神圣时间戳 < 15e3
    return false

  摇荡()
  
  $.setInterval 监听焦热, 技能施放判断间隔
  return true

监听焦热 = ->
  unless isUsed '焦热'
    return
  $.clearInterval 监听焦热
  焦热时间戳 = A_TickCount - 技能施放时间戳补正

# ---

索敌 = ->

  hasTarget = isTargeting()
  if hasTarget
    return true

  $.press 'f11'

  hasTarget = isTargeting()
  return hasTarget

# ---

中断咏唱 = ->
  unless isChanting()
    return
  $.press 'space'

# ---

能力技时间戳 = 0
能力技冷却 = 1e3
能力技余额 = 0

能力技 = (n = 2) ->
  
  unless A_TickCount - 能力技时间戳 > 能力技冷却
    return
  
  能力技时间戳 = A_TickCount
  能力技余额 = -n

  $.setInterval 施放能力技, 500

施放能力技 = ->

  if 能力技余额 < 0
    能力技余额 = -能力技余额
    return

  unless 能力技余额 > 0
    $.clearInterval 施放能力技
    return
  能力技余额--

  能力技施放()

能力技施放 = ->

  if 倍增()
    return

  if 鼓励()
    return

  if 促进()
    return

  if 即刻咏唱()
    return

  if 飞刺()
    return

  if 六分反击()
    return

  if 短兵相接()
    return

  if 交剑()
    return
  
  if 醒梦()
    return