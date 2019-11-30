# use admin

# skill

# include 技能

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

getBlack = ->
  [x, y] = $.findColor '#56463c', 1027, 810, 1166, 810
  
  unless x
    return 100
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.round percent
  return percent - 1

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

getWhite = ->
  [x, y] = $.findColor '#2e1e14', 1027, 801, 1166, 801
  
  unless x
    return 100
  
  percent = (x - 1023) * 100 / (1170 - 1023)
  percent = Math.round percent
  return percent - 1

hasStatus = (name) ->

  [x, y] = $.findImage "#{name}.png", 725, 840, 925, 875
  
  if x > 0 and y > 0
    return true
  return false

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

isViewFar = false
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

魔元报警 = (black, white) ->
  total = white + black
  if total > 170 and total < 200
    $.beep()

施放赤飞石 = (black, white, isBR, isWR) ->

  if black - white > 21
    赤飞石()
    return true

  if white - black > 21
    赤火炎()
    return true

  if isWR and isBR
    if white >= black
      赤火炎()
    else
      赤飞石()
    return true

  if isWR
    赤飞石()
    return true

  if isBR
    赤火炎()
    return true

  return false

施放赤疾风 = (black, white, isBR, isWR) ->

  unless hasStatus '连续咏唱'
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

单体攻击 = ->
  
  索敌()

  black = getBlack()
  white = getWhite()
  魔元报警 black, white

  isWR = hasStatus '赤飞石预备'
  isBR = hasStatus '赤火炎预备'

  if 施放赤疾风 black, white, isBR, isWR
    delay '促进'
    delay '能力技'
    return

  if isMoving()
    续斩()
    delay '能力技'
    return

  if 施放赤飞石 black, white, isBR, isWR
    return
  
  摇荡()

群体攻击 = ->

  索敌()

  black = getBlack()
  white = getWhite()
  魔元报警 black, white

  if hasStatus '连续咏唱'
    散碎()
    delay '能力技'
    return

  if isMoving()
    续斩()
    delay '能力技'
    return

  if white >= black
    赤震雷()
  else
    赤烈风()

魔三连 = ->

  if hasStatus '连续咏唱'
    攻击()
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

攻击 = ->

  group = getGroup()

  # 单体攻击
  if group == 'right'
    单体攻击()
    return

  # 群体攻击
  if group == 'both'
    群体攻击()
    return

$.on '2-joy-4', ->
  $.loop ->

    isPressing = $.isPressing '2-joy-4'
    unless isPressing
      break

    攻击()

    await $.sleep 300

特殊攻击 = ->

  group = getGroup()

  if group == 'right'
    魔三连()
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

$.on '2-joy-2', ->
  $.loop ->

    isPressing = $.isPressing '2-joy-2'
    unless isPressing
      break

    特殊攻击()

    await $.sleep 300

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