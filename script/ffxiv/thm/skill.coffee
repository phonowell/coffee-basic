冰结 = -> $.press 'alt + 1'
火炎 = -> $.press 'alt + 2'
星灵移位 = -> $.press 'alt + 3'

# ---

闪雷时间戳 = 0
闪雷冷却 = 10e3

闪雷 = ->

  if !isDotEnabled
    return false

  unless A_TickCount - 闪雷时间戳 > 闪雷冷却
    return false

  if hasStatusTarget '闪雷'
    return false

  $.press 'alt + 4'

  闪雷时间戳 = A_TickCount - 2e3
  return true

# ---

催眠 = -> $.press 'alt + 5'
冰冻 = -> $.press 'alt + 6'
崩溃 = -> $.press 'alt + 7'
烈炎 = -> $.press 'alt + 8'

# ---

震雷时间戳 = 0
震雷冷却 = 10e3

震雷 = ->

  unless A_TickCount - 震雷时间戳 > 震雷冷却
    return false

  if hasStatusTarget '震雷'
    return false

  $.press 'alt + 9'

  震雷时间戳 = A_TickCount - 2e3
  return true

# ---

魔罩 = -> $.press 'alt + 0'
爆炎 = -> $.press 'alt + minus'
以太步 = -> $.press 'alt + equal'
昏乱 = -> $.press 'ctrl + 1'

# ---

即刻咏唱时间戳 = 0
即刻咏唱冷却 = 60e3

即刻咏唱 = ->

  unless A_TickCount - 即刻咏唱时间戳 > 即刻咏唱冷却
    return false

  $.press 'ctrl + 2'

  $.setInterval 监听即刻咏唱, 200
  return true

监听即刻咏唱 = ->

  unless isChanted '即刻咏唱2'
    return

  $.clearInterval 监听即刻咏唱
  即刻咏唱时间戳 = A_TickCount - 2e3

# ---

醒梦 = -> $.press 'ctrl + 3'
沉稳咏唱 = -> $.press 'ctrl + 4'

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