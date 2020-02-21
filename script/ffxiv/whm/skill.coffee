技能施放判断间隔 = 100
技能施放时间戳补正 = 1500

# ---

飞石 = -> $.press 'alt + 1'
治疗 = -> $.press 'alt + 2'

# ---

疾风 = ->

  unless isMoving()
  
    if hasStatusTarget '天辉'
      return false
    if hasStatusTarget '烈风'
      return false
    if hasStatusTarget '疾风'
      return false
  
  $.press 'alt + 3'
  return true

# ---

医治 = -> $.press 'alt + 4'
复活 = -> $.press 'alt + 5'
水流环 = -> $.press 'alt + 6'
救疗 = -> $.press 'alt + 7'

# ---

医济 = ->
  
  if hasStatus '医济'
    return false
  
  $.press 'alt + 8'
  return true

# ---

神速咏唱时间戳 = 0
神速咏唱冷却 = 150e3

神速咏唱 = ->

  unless A_TickCount - 神速咏唱时间戳 > 神速咏唱冷却
    return false

  $.press 'alt + 9'

  神速咏唱时间戳 = A_TickCount - 神速咏唱冷却 + 技能施放时间戳补正
  $.setInterval 监听神速咏唱, 技能施放判断间隔
  return true

监听神速咏唱 = ->
  unless hasStatus '神速咏唱'
    return
  $.clearInterval 监听神速咏唱
  神速咏唱时间戳 = A_TickCount - 技能施放时间戳补正

# ---

再生 = ->
  
  if hasStatusTarget '再生'
    return false

  unless 能力技冷却判断()
    return false
  
  $.press 'alt + 0'
  return true

# ---

愈疗 = -> $.press 'alt + minus'
神圣 = -> $.press 'alt + equal'
天赐祝福 = -> $.press 'ctrl + 1'

# ---

安慰之心 = ->

  unless white >= 1
    return false

  unless 能力技冷却判断()
    return false

  $.press 'ctrl + 2'
  return true

# ---

庇护所 = -> $.press 'ctrl + 3'

# ---

法令时间戳 = 0
法令冷却 = 45e3

法令 = ->

  unless A_TickCount - 法令时间戳 > 法令冷却
    return false

  $.press 'ctrl + 4'

  法令时间戳 = A_TickCount - 法令冷却 + 技能施放时间戳补正
  $.setInterval 监听法令, 技能施放判断间隔
  return true

监听法令 = ->
  unless isUsed '法令'
    return
  $.clearInterval 监听法令
  法令时间戳 = A_TickCount - 技能施放时间戳补正

# ---

无中生有时间戳 = 0
无中生有冷却 = 120e3

无中生有 = ->

  unless A_TickCount - 无中生有时间戳 > 无中生有冷却
    return false

  $.press 'ctrl + 5'

  无中生有时间戳 = A_TickCount - 无中生有冷却 + 技能施放时间戳补正
  $.setInterval 监听无中生有, 技能施放判断间隔
  return true

监听无中生有 = ->
  unless hasStatus '无中生有'
    return
  $.clearInterval 监听无中生有
  无中生有时间戳 = A_TickCount - 技能施放时间戳补正

# ---

神名时间戳 = 0
神名冷却 = 60e3

神名 = ->

  unless A_TickCount - 神名时间戳 > 神名冷却
    return false

  unless 能力技冷却判断()
    return false

  $.press 'ctrl + 6'

  神名时间戳 = A_TickCount - 神名冷却 + 技能施放时间戳补正
  $.setInterval 监听神名, 技能施放判断间隔
  return true

监听神名 = ->
  unless isUsed '神名'
    return
  $.clearInterval 监听神名
  神名时间戳 = A_TickCount - 技能施放时间戳补正

# ---

神祝祷 = -> $.press 'ctrl + 7'

# ---

全大赦时间戳 = 0
全大赦冷却 = 60e3

全大赦 = ->

  unless A_TickCount - 全大赦时间戳 > 全大赦冷却
    return false

  unless 能力技冷却判断()
    return false

  $.press 'ctrl + 8'

  全大赦时间戳 = A_TickCount - 全大赦冷却 + 技能施放时间戳补正
  $.setInterval 监听全大赦, 技能施放判断间隔
  return true

监听全大赦 = ->
  unless isUsed '全大赦'
    return
  $.clearInterval 监听全大赦
  全大赦时间戳 = A_TickCount - 技能施放时间戳补正

# ---

苦难之心 = ->

  unless red >= 3
    return false

  $.press 'ctrl + 9'
  return true

# ---

狂喜之心 = ->

  unless white >= 1
    return false

  unless 能力技冷却判断()
    return false

  $.press 'ctrl + 0'
  return true

# ---

节制 = -> $.press 'ctrl + minus'
沉静 = -> $.press 'shift + 1'
康复 = -> $.press 'shift + 2'

# ---

即刻咏唱时间戳 = 0
即刻咏唱冷却 = 60e3

即刻咏唱 = ->

  unless A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却
    return false

  $.press 'shift + 3'

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

  $.press 'shift + 4'
  
  醒梦时间戳 = A_TickCount - 醒梦冷却 + 技能施放时间戳补正
  $.setInterval 监听醒梦, 技能施放判断间隔
  return true

监听醒梦 = ->
  unless hasStatus '醒梦'
    return
  $.clearInterval 监听醒梦
  醒梦时间戳 = A_TickCount - 技能施放时间戳补正

# ---

沉稳咏唱 = -> $.press 'shift + 5'
营救 = -> $.press 'shift + 6'
冲刺 = -> $.press 'shift + minus'
清空信息 = -> $.press 'shift + equal'

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
能力技冷却 = 300

能力技冷却判断 = ->

  unless A_TickCount - 能力技时间戳 > 能力技冷却
    return false

  能力技时间戳 = A_TickCount
  return true