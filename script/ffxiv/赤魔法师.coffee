# use admin

# const

isViewFar = false

# skill

回刺 = -> $.press 'alt + 1'
摇荡 = -> $.press 'alt + 2'
赤闪雷 = -> $.press 'alt + 3'
短兵相接 = -> $.press 'alt + 4'
赤疾风 = -> $.press 'alt + 5'
散碎 = -> $.press 'alt + 6'
赤震雷 = -> $.press 'alt + 7'
赤烈风 = -> $.press 'alt + 8'
赤火炎 = -> $.press 'alt + 9'
赤飞石 = -> $.press 'alt + 0'
交击斩 = -> $.press 'alt + minus'
移转 = -> $.press 'alt + equal'
飞刺 = -> $.press 'ctrl + 1'
连攻 = -> $.press 'ctrl + 2'
促进 = -> $.press 'ctrl + 3'
划圆斩 = -> $.press 'ctrl + 4'
赤治疗 = -> $.press 'ctrl + 5'
六分反击 = -> $.press 'ctrl + 6'
鼓励 = -> $.press 'ctrl + 7'

倍增 = ->
  white = getWhite()
  unless white >= 40 and white <= 60
    return false
  black = getBlack()
  unless black >= 40 and black <= 60
    return false
  $.press 'ctrl + 8'
  return true

震荡 = -> $.press 'ctrl + 9'
赤复活 = -> $.press 'ctrl + 0'
冲击 = -> $.press 'ctrl + minus'
交剑 = -> $.press 'ctrl + equal'
续斩 = -> $.press 'shift + 1'
昏乱 = -> $.press 'shift + 2'
即刻咏唱 = -> $.press 'shift + 3'

醒梦 = ->
  color = $.getColor 260, 35
  unless color == 0x56463C
    return false
  $.press 'shift + 4'
  return true

沉稳咏唱 = -> $.press 'shift + 5'
索敌 = -> $.press 'shift + 6'
爆发药 = -> $.press 'shift + 7'

能力技 = ->
  索敌()
  倍增()
  飞刺()
  六分反击()
  交剑()
  昏乱()
  醒梦()

# function

delay = (name, time = 300, n = 1) ->
  $.loop n, ->
    if n != 1
      await $.sleep time
    $.clearTimeout name
    $.setTimeout name, time

getGroup = ->

  isLT = false
  isRT = false

  isLT = $.isPressing '2joy7'
  isRT = $.isPressing '2joy8'

  if isLT and isRT
    return 'both'

  if isLT
    return 'left'

  if isRT
    return 'right'

  return 'none'

hasStatus = (name) ->

  [x, y] = $.findImage "#{name}.png", 725, 840, 925, 875
  
  if x > 0 and y > 0
    return true
  return false

toggleView = ->

  if isViewFar == false

    $.press 'ctrl:down', 'up:down', 'page-down:down'
    await $.sleep 3e3
    $.press 'ctrl:up', 'up:up', 'page-down:up'

    isViewFar = true

  else

    $.press 'ctrl:down', 'down:down', 'page-up:down'
    await $.sleep 3e3
    $.press 'ctrl:up', 'down:up', 'page-up:up'

    isViewFar = false

  $.beep()

# ---

attackCombo = ->

  if hasStatus '连续咏唱'
    $.beep()
    return

  索敌()

  white = getWhite()
  black = getBlack()

  if white >= 80 and black >= 80
    回刺()
    短兵相接()
    return

  if white >= 50 and black >= 50
    交击斩()
    鼓励()
    return

  if white >= 25 and black >= 25
    连攻()
    交剑()
    短兵相接()
    return

  if white >= black
    赤闪雷()
  else
    赤疾风()
    
  delay '能力技'

attackMulti = ->

  索敌()

  if isMoving()
    续斩()
    delay '能力技'
    return

  white = getWhite()
  black = getBlack()

  if white > 90 or black > 90
    $.beep()

  if hasStatus '连续咏唱'
    散碎()
    delay '能力技'
    return

  if white >= black
    赤震雷()
  else
    赤烈风()

attackSingle = ->
  
  索敌()

  if isMoving()
    续斩()
    delay '能力技'
    return

  white = getWhite()
  black = getBlack()

  # $.tip "#{white} / #{black}"
  total = white + black
  if total > 170 and total < 200
    $.beep()

  isW = hasStatus '赤飞石预备'
  isB = hasStatus '赤火炎预备'

  if hasStatus '连续咏唱'

    if isW
      赤闪雷()
    else if isB
      赤疾风()
    else
      if white >= black
        赤闪雷()
      else
        赤疾风()

    delay '促进'
    delay '能力技'
    return

  if isW and isB
    if white >= black
      赤火炎()
    else
      赤飞石()
    return

  if isW
    赤飞石()
    return

  if isB
    赤火炎()
    return
  
  摇荡()

getBlack = ->
  [x, y] = $.findColor '#56463c', 1027, 810, 1166, 810
  
  unless x
    return 100
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.round percent
  return percent - 1

getWhite = ->
  [x, y] = $.findColor '#2e1e14', 1027, 801, 1166, 801
  
  unless x
    return 100
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.round percent
  return percent - 1

isMoving = ->

  dis = $.getState '2-joy-x'
  if dis < 40
    return true
  if dis > 60
    return true

  dis = $.getState '2-joy-y'
  if dis < 40
    return true
  if dis > 60
    return true

  return false

# bind

$.on 'f12', ->
  $.beep()
  $.exit()

$.on 'f6', ->
  [x, y] = $.getPosition()
  color = $.getColor x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'f7', ->
  white = getWhite()
  black = getBlack()
  $.tip "#{white} / #{black}"

$.on 'f8', ->
  x = 1100
  y = 935
  color = $.getColor x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'f2', ->
  toggleView()

# ---

$.on '2-joy-4', ->

  group = getGroup()

  # 单体攻击
  if group == 'right'
    attackSingle()
    return

  # 群体攻击
  if group == 'both'
    attackMulti()
    return

$.on '2-joy-2', ->

  group = getGroup()

  if group == 'right'
    attackCombo()
    return

  if group == 'both'

    if getWhite() < 20
      $.beep()
      return
    if getBlack() < 20
      $.beep()
      return
    
    if hasStatus '连续咏唱'
      $.beep()
      return
    
    索敌()
    划圆斩()
    delay '能力技'
    return

$.on '2-joy-1', ->

  group = getGroup()

  if group == 'right'
    
    if hasStatus '连续咏唱'
      $.beep()
      return
    
    索敌()
    摇荡()
    delay '能力技'
    return

$.on '2-joy-3', ->

  group = getGroup()

  if group == 'right'
    赤治疗()
    return

  if group == 'both'
    赤复活()
    delay '能力技'
    return