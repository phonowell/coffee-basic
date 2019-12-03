回刺时间戳 = 0
回刺冷却 = 10e3

回刺 = ->

  unless A_TickCount - 回刺时间戳 > 回刺冷却
    return false

  unless black >= 80 and white >= 80
    return false

  $.press 'alt + 1'
  return true

监听回刺 = ->

  unless A_TickCount - 回刺时间戳 > 回刺冷却
    return

  unless isChanted '魔回刺'
    return
      
  回刺时间戳 = A_TickCount - 2e3

# ---

摇荡 = -> $.press 'alt + 2'
赤闪雷 = -> $.press 'alt + 3'

# ---

短兵相接时间戳 = 0
短兵相接冷却 = 40e3

短兵相接 = ->

  unless asr > 0
    return false

  unless A_TickCount - 短兵相接时间戳 > 短兵相接冷却
    return false

  $.press 'alt + 4'
  asr--
  return true

监听短兵相接 = ->

  unless A_TickCount - 短兵相接时间戳 > 短兵相接冷却
    return

  unless isChanted '短兵相接'
    return

  短兵相接时间戳 = A_TickCount - 2e3

# ---

赤疾风 = -> $.press 'alt + 5'
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

  unless A_TickCount - 回刺时间戳 < 15e3
    return false

  unless black >= 50 and white >= 50
    return false

  $.press 'alt + minus'
  return true

监听交击斩 = ->

  unless A_TickCount - 交击斩时间戳 > 交击斩冷却
    return

  unless isChanted '魔交击斩'
    return

  交击斩时间戳 = A_TickCount - 2e3

# ---

移转 = -> $.press 'alt + equal'

# ---

飞刺时间戳 = 0
飞刺冷却 = 25e3

飞刺 = ->

  unless asr > 0
    return

  unless A_TickCount - 飞刺时间戳 > 飞刺冷却
    return false
  
  $.press 'ctrl + 1'
  asr--
  return true

监听飞刺 = ->

  unless A_TickCount - 飞刺时间戳 > 飞刺冷却
    return

  unless isChanted '飞刺'
    return

  飞刺时间戳 = A_TickCount - 2e3

# ---

连攻时间戳 = 0
连攻冷却 = 10e3

连攻 = ->

  unless A_TickCount - 连攻时间戳 > 连攻冷却
    return false

  unless A_TickCount - 交击斩时间戳 < 15e3
    return false

  unless black >= 25 and white >= 25
    return false

  $.press 'ctrl + 2'
  return true

监听连攻 = ->

  unless A_TickCount - 连攻时间戳 > 连攻冷却
    return

  unless isChanted '魔连攻'
    return

  连攻时间戳 = A_TickCount - 2e3

# ---

促进时间戳 = 0
促进冷却 = 35e3

促进 = ->

  unless asr > 0
    return

  unless A_TickCount - 促进时间戳 > 促进冷却
    return false

  if black > 80 or white > 80
    return false

  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'
  if isBR and isWR
    return false

  $.press 'ctrl + 3'
  asr--
  return true

监听促进 = ->

  unless A_TickCount - 促进时间戳 > 促进冷却
    return

  unless isChanted '促进2'
    return

  促进时间戳 = A_TickCount - 2e3

# ---

划圆斩时间戳 = 0
划圆斩 = ->

  unless black >= 20 and white >= 20
    return false

  $.press 'ctrl + 4'

  unless isChanted '魔划圆斩'
    return false

  划圆斩时间戳 = A_TickCount - 2e3
  return true

# ---

赤治疗 = -> $.press 'ctrl + 5'

# ---

六分反击时间戳 = 0
六分反击冷却 = 35e3

六分反击 = ->

  unless asr > 0
    return

  unless A_TickCount - 六分反击时间戳 > 六分反击冷却
    return false

  $.press 'ctrl + 6'
  asr--
  return true

监听六分反击 = ->

  unless A_TickCount - 六分反击时间戳 > 六分反击冷却
    return

  unless isChanted '六分反击'
    return

  六分反击时间戳 = A_TickCount - 2e3

# ---

鼓励时间戳 = 0
鼓励冷却 = 120e3

鼓励 = ->

  unless asr > 0
    return

  unless A_TickCount - 鼓励时间戳 > 鼓励冷却
    return false

  $.press 'ctrl + 7'
  asr--
  return true

监听鼓励 = ->

  unless A_TickCount - 鼓励时间戳 > 鼓励冷却
    return

  unless isChanted '鼓励'
    return

  鼓励时间戳 = A_TickCount - 2e3

# ---

倍增时间戳 = 0
倍增冷却 = 110e3

倍增 = ->

  unless asr > 0
    return

  unless white >= 40 and white < 70
    return false

  unless black >= 40 and black < 70
    return false

  $.press 'ctrl + 8'
  asr--
  return true

监听倍增 = ->

  unless A_TickCount - 倍增时间戳 > 倍增冷却
    return

  unless isChanted '倍增'
    return

  倍增时间戳 = A_TickCount - 2e3
  短兵相接时间戳 = 0
  交剑时间戳 = 0

# ---

震荡 = -> $.press 'ctrl + 9'
赤复活 = -> $.press 'ctrl + 0'
冲击 = -> $.press 'ctrl + minus'

# ---

交剑时间戳 = 0
交剑冷却 = 35e3

交剑 = ->

  unless asr > 0
    return

  unless A_TickCount - 交剑时间戳 > 交剑冷却
    return false

  $.press 'ctrl + equal'
  asr--
  return true

监听交剑 = ->

  unless A_TickCount - 交剑时间戳 > 交剑冷却
    return

  unless isChanted '交剑'
    return

  交剑时间戳 = A_TickCount - 2e3

# ---

续斩 = -> $.press 'shift + 1'

# ---

昏乱 = -> $.press 'shift + 2'

# ---

即刻咏唱时间戳 = 0
即刻咏唱冷却 = 60e3

即刻咏唱 = ->

  unless asr > 0
    return

  unless A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却
    return false

  if black > 60 or white > 60
    return false

  if hasStatus '连续咏唱'
    return false

  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'
  if isBR and isWR
    return

  $.press 'shift + 3'
  asr--
  return true

监听即刻咏唱 = ->

  unless A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却
    return

  unless isChanted '即刻咏唱2'
    return

  即刻咏唱时间戳 = A_TickCount - 2e3

# ---

醒梦时间戳 = 0
醒梦冷却 = 60e3

醒梦 = ->

  unless asr > 0
    return

  unless A_TickCount - 醒梦时间戳 > 醒梦冷却
    return false

  if mp > 65
    return false

  $.press 'shift + 4'
  asr--
  return true

监听醒梦 = ->

  unless A_TickCount - 醒梦时间戳 > 醒梦冷却
    return

  unless isChanted '醒梦'
    return

  醒梦时间戳 = A_TickCount - 2e3

# ---

沉稳咏唱 = -> $.press 'shift + 5'

# ---

索敌时间戳 = 0
索敌冷却 = 3e3

索敌 = ->

  unless A_TickCount - 索敌时间戳 > 索敌冷却
    return false

  if isChanting()
    return false

  $.press 'shift + minus'

  索敌时间戳 = A_TickCount - 2e3
  return true

# ---

清空信息 = -> $.press 'shift + equal'

# ---
asr = 0
能力技 = ->

  unless asr > 0
    return false
  
  if 飞刺()
    return true

  if 六分反击()
    return true

  if 交剑()
    return true
  
  if 醒梦()
    return true

# ---

赤神圣时间戳 = 0
赤神圣冷却 = 10e3

赤神圣 = ->

  unless A_TickCount - 赤神圣时间戳 > 赤神圣冷却
    return false

  unless A_TickCount - 连攻时间戳 < 15e3
    return false

  if black - white > 9
    赤疾风()
    return true

  if white - black > 9
    赤闪雷()
    return true

  isBR = hasStatus '赤火炎预备'
  isWR = hasStatus '赤飞石预备'

  if isBR and isWR
    if black > white
      赤疾风()
    else
      赤闪雷()
    return true

  if isBR
    赤疾风()
    return true

  if isWR
    赤闪雷()
    return true

  if black > white
    赤疾风()
  else
    赤闪雷()
  return true

监听赤神圣 = ->

  unless A_TickCount - 赤神圣时间戳 > 赤神圣冷却
    return

  isBR = isChanted '赤核爆'
  isWR = isChanted '赤神圣'

  unless isBR or isWR
    return

  赤神圣时间戳 = A_TickCount - 2e3

# ---

焦热 = ->

  unless A_TickCount - 赤神圣时间戳 < 15e3
    return false

  摇荡()

  回刺时间戳 = 0
  交击斩时间戳 = 0
  连攻时间戳 = 0
  赤神圣时间戳 = 0
  $.beep()
  
  return true