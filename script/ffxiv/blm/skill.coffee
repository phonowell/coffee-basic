冰结 = -> $.press 'alt + 1'
火炎 = -> $.press 'alt + 2'
星灵移位 = -> $.press 'alt + 3'

# ---

ts.闪雷 = 0
cd.闪雷 = 10e3

闪雷 = ->

  if !isDotEnabled
    return false

  unless A_TickCount - ts.闪雷 > cd.闪雷
    return false

  if hasStatusTarget '闪雷'
    return false

  $.press 'alt + 4'

  ts.闪雷 = A_TickCount - 2e3
  return true

# ---

催眠 = -> $.press 'alt + 5'
冰冻 = -> $.press 'alt + 6'
崩溃 = -> $.press 'alt + 7'
烈炎 = -> $.press 'alt + 8'

# ---

ts.震雷 = 0
cd.震雷 = 10e3

震雷 = ->

  unless A_TickCount - ts.震雷 > cd.震雷
    return false

  if hasStatusTarget '震雷'
    return false

  $.press 'alt + 9'

  ts.震雷 = A_TickCount - 2e3
  return true

# ---

魔罩 = -> $.press 'alt + 0'
爆炎 = -> $.press 'alt + minus'
以太步 = -> $.press 'alt + equal'
昏乱 = -> $.press 'shift + 4'

# ---

ts.即刻咏唱 = 0
cd.即刻咏唱 = 60e3

即刻咏唱 = ->

  unless A_TickCount - ts.即刻咏唱 > cd.即刻咏唱
    return false

  $.press 'shift + 5'

  $.setInterval 监听即刻咏唱, 200
  return true

监听即刻咏唱 = ->

  unless isUsed '即刻咏唱2'
    return

  $.clearInterval 监听即刻咏唱
  ts.即刻咏唱 = A_TickCount - 2e3

# ---

醒梦 = -> $.press 'shift + 6'
沉稳咏唱 = -> $.press 'shift + 7'

# ---

索敌 = ->

  ehp = getEnemyHp()
  if ehp
    return false

  $.press 'f11'
  return true

# ---

清空信息 = -> $.press 'shift + equal'