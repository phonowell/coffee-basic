asr = 0

# ---

飞石 = -> $.press 'alt + 1'

# ---

治疗 = ->

  unless asr > 0
    return false

  $.press 'alt + 2'
  return true

# ---

疾风 = ->

  unless asr > 0
    return false

  unless isMoving()
  
    if hasStatusTarget '天辉'
      return false
    if hasStatusTarget '烈风'
      return false
    if hasStatusTarget '疾风'
      return false
  
  $.press 'alt + 3'

  asr--
  return true

# ---

医治 = ->

  unless asr > 0
    return false

  $.press 'alt + 4'
  return true

# ---

复活 = ->
  asr = 2
  即刻咏唱()
  无中生有()
  $.press 'alt + 5'
  return true

# ---

水流环 = -> $.press 'alt + 6'

# ---

救疗 = ->
  
  unless asr > 0
    return false

  $.press 'alt + 7'
  return true

# ---

医济 = ->

  unless asr > 0
    return false
  
  if hasStatus '医济'
    return false
  
  $.press 'alt + 8'
  return true

# ---

神速咏唱时间戳 = 0
神速咏唱冷却 = 150e3

神速咏唱 = ->

  unless asr > 0
    return false

  unless A_TickCount - 神速咏唱时间戳 > 神速咏唱冷却
    return false

  $.press 'alt + 9'

  $.setInterval 监听神速咏唱, 200
  asr--
  return true

监听神速咏唱 = ->

  unless hasStatus '神速咏唱'
    return

  神速咏唱时间戳 = A_TickCount - 2e3
  $.clearInterval 监听神速咏唱

# ---

再生 = ->

  unless asr > 0
    return false
  
  if hasStatusTarget '再生'
    return false
  
  $.press 'alt + 0'
  
  asr--
  return true

# ---

愈疗 = -> $.press 'alt + minus'
神圣 = -> $.press 'alt + equal'
天赐祝福 = -> $.press 'ctrl + 1'

# ---

安慰之心 = ->

  unless asr > 0
    return false

  unless white >= 1
    return false

  $.press 'ctrl + 2'

  asr--
  return true

# ---

庇护所 = -> $.press 'ctrl + 3'

# ---

法令时间戳 = 0
法令冷却 = 45e3

法令 = ->

  unless asr > 0
    return false

  unless A_TickCount - 法令时间戳 > 法令冷却
    return false

  $.press 'ctrl + 4'

  $.setInterval 监听法令, 200
  asr--
  return true

监听法令 = ->

  unless isUsed '法令'
    return

  法令时间戳 = A_TickCount - 2e3
  $.clearInterval 监听法令

# ---

无中生有时间戳 = 0
无中生有冷却 = 120e3

无中生有 = ->

  unless asr > 0
    return false

  unless A_TickCount - 无中生有时间戳 > 无中生有冷却
    return false

  $.press 'ctrl + 5'

  $.setInterval 监听无中生有, 200
  asr--
  return true

监听无中生有 = ->

  unless hasStatus '无中生有'
    return

  无中生有时间戳 = A_TickCount - 2e3
  $.clearInterval 监听无中生有

# ---

神名时间戳 = 0
神名冷却 = 60e3

神名 = ->

  unless asr > 0
    return false

  unless A_TickCount - 神名时间戳 > 神名冷却
    return false

  $.press 'ctrl + 6'

  $.setInterval 监听神名, 200
  asr--
  return true

监听神名 = ->

  unless isUsed '神名'
    return

  神名时间戳 = A_TickCount - 2e3
  $.clearInterval 监听神名

# ---

神祝祷 = -> $.press 'ctrl + 7'

# ---

全大赦时间戳 = 0
全大赦冷却 = 60e3

全大赦 = ->

  unless asr > 0
    return false

  unless A_TickCount - 全大赦时间戳 > 全大赦冷却
    return false

  $.press 'ctrl + 8'

  $.setInterval 监听全大赦, 200
  asr--
  return true

监听全大赦 = ->

  unless isUsed '全大赦'
    return

  全大赦时间戳 = A_TickCount - 2e3
  $.clearInterval 监听全大赦

# ---

苦难之心 = ->

  unless red >= 3
    return false

  $.press 'ctrl + 9'
  return true

# ---

狂喜之心 = ->

  unless asr > 0
    return false

  unless white >= 1
    return false

  $.press 'ctrl + 0'

  asr--
  return true

# ---

节制 = -> $.press 'ctrl + minus'
沉静 = -> $.press 'ctrl + equal'
康复 = -> $.press 'shift + 1'

# ---

即刻咏唱时间戳 = 0
即刻咏唱冷却 = 60e3

即刻咏唱 = ->

  unless asr > 0
    return false

  unless A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却
    return false

  $.press 'shift + 2'

  $.setInterval 监听即刻咏唱, 200
  asr--
  return true

监听即刻咏唱 = ->

  unless hasStatus '即刻咏唱'
    return

  即刻咏唱时间戳 = A_TickCount - 2e3
  $.clearInterval 监听即刻咏唱

# ---

醒梦时间戳 = 0
醒梦冷却 = 60e3

醒梦 = ->

  # unless asr > 0
  #   return false

  unless A_TickCount - 醒梦时间戳 > 醒梦冷却
    return false

  mp = getMp()
  if mp > 50
    return false

  $.press 'shift + 3'

  $.setInterval 监听醒梦, 200
  # asr--
  return true

监听醒梦 = ->

  unless hasStatus '醒梦'
    return

  醒梦时间戳 = A_TickCount - 2e3
  $.clearInterval 监听醒梦

# ---

沉稳咏唱 = -> $.press 'shift + 4'
营救 = -> $.press 'shift + 5'

# ---

索敌时间戳 = 0
索敌冷却 = 5e3

索敌 = ->

  unless A_TickCount - 索敌时间戳 > 索敌冷却
    return false

  if isChanting()
    return false

  $.press 'f11'

  索敌时间戳 = A_TickCount - 2e3
  return true

# ---

清空信息 = -> $.press 'shift + equal'