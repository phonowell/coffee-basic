# use admin

# const

isViewFar = false

# skill

回刺 = ->
  $.press 'alt:down', '1', 'alt:up'
摇荡 = ->
  $.press 'alt:down', '2', 'alt:up'
赤闪雷 = ->
  $.press 'alt:down', '3', 'alt:up'
短兵相接 = ->
  $.press 'alt:down', '4', 'alt:up'
赤疾风 = ->
  $.press 'alt:down', '5', 'alt:up'
散碎 = ->
  $.press 'alt:down', '6', 'alt:up'
赤震雷 = ->
  $.press 'alt:down', '7', 'alt:up'
赤烈风 = ->
  $.press 'alt:down', '8', 'alt:up'
赤火炎 = ->
  $.press 'alt:down', '9', 'alt:up'
赤飞石 = ->
  $.press 'alt:down', '0', 'alt:up'
交击斩 = ->
  $.press 'alt:down', 'minus', 'alt:up'
移转 = ->
  $.press 'alt:down', 'equal', 'alt:up'
飞刺 = ->
  $.press 'ctrl:down', '1', 'ctrl:up'
连攻 = ->
  $.press 'ctrl:down', '2', 'ctrl:up'
促进 = ->
  $.press 'ctrl:down', '3', 'ctrl:up'
划圆斩 = ->
  $.press 'ctrl:down', '4', 'ctrl:up'
赤治疗 = ->
  $.press 'ctrl:down', '5', 'ctrl:up'
六分反击 = ->
  $.press 'ctrl:down', '6', 'ctrl:up'
鼓励 = ->
  $.press 'ctrl:down', '7', 'ctrl:up'
倍增 = ->
  $.press 'ctrl:down', '8', 'ctrl:up'
震荡 = ->
  $.press 'ctrl:down', '9', 'ctrl:up'
赤复活 = ->
  $.press 'ctrl:down', '0', 'ctrl:up'
冲击 = ->
  $.press 'ctrl:down', 'minus', 'ctrl:up'
交剑 = ->
  $.press 'ctrl:down', 'equal', 'ctrl:up'
续斩 = ->
  $.press 'shift:down', '1', 'shift:up'
昏乱 = ->
  $.press 'shift:down', '2', 'shift:up'
即刻咏唱 = ->
  $.press 'shift:down', '3', 'shift:up'
醒梦 = ->
  $.press 'shift:down', '4', 'shift:up'
沉稳咏唱 = ->
  $.press 'shift:down', '5', 'shift:up'
索敌 = ->
  $.press 'shift:down', '6', 'shift:up'

能力技 = ->
  索敌()
  交剑()
  飞刺()
  六分反击()
  昏乱()

# ---

施放赤疾风 = ->

  res = hasStatus '连续咏唱'
  if !res

    res = hasStatus '赤飞石预备'
    if res
      赤飞石()
      return

    摇荡()
    return
  
  赤疾风()
  促进()
  施放醒梦()
  delay '能力技', 300, 2

施放赤闪雷 = ->

  res = hasStatus '连续咏唱'
  if !res

    res = hasStatus '赤火炎预备'
    if res
      赤火炎()
      return

    摇荡()
    return

  赤闪雷()
  促进()
  施放醒梦()
  delay '能力技', 300, 2

施放赤烈风 = ->

  res = hasStatus '连续咏唱'
  if !res

    赤烈风()
    return

  散碎()
  施放醒梦()
  delay '能力技', 300, 2

施放赤震雷 = ->

  res = hasStatus '连续咏唱'
  if !res

    赤震雷()
    return

  散碎()
  施放醒梦()
  delay '能力技', 300, 2

施放醒梦 = ->
  color = $.getColor 265, 40
  if color == 0x3B5264
    醒梦()

# function

delay = (name, time = 300, n = 1) ->
  $.loop n, ->
    if n != 1
      await $.sleep time
    $.clearTimeout name
    $.setTimeout name, time

getGroup = ->
  
  color = $.getColor 965, 930
  if color == 0x6CA9BD
    return 'r1'
  if color == 0x7F6967
    return 'r2'
  
  color = $.getColor 740, 930
  if color == 0x6BA8BD
    return 'l1'
  if color == 0x7F6866
    return 'l2'

  return 'none'

hasStatus = (name) ->

  [x, y] = $.find "#{name}.png", 725, 840, 925, 875
  
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

# bind

$.on 'f12', ->
  $.beep()
  $.exit()

$.on 'f9', ->
  [x, y] = $.getPosition()
  # x = 265
  # y = 40
  color = $.getColor x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'f2', ->
  toggleView()

# ---

$.on '2joy4', ->

  group = getGroup()
  if group == 'none'
    return

  索敌()

  if group == 'r1'
    # 短兵相接
    delay '能力技', 300, 2
    return

  if group == 'r2'
    # 回刺
    delay '短兵相接'
    return

  if group == 'l1'
    # 划圆斩
    delay '能力技'
    return

$.on '2joy2', ->

  group = getGroup()
  if group == 'none'
    return

  索敌()
  
  if group == 'r1'
    施放赤疾风()
    return

  if group == 'r2'
    # 交击斩
    delay '鼓励'
    return

  if group == 'l1'
    施放赤烈风()
    return

$.on '2joy1', ->

  group = getGroup()
  if group == 'none'
    return

  索敌()
  
  if group == 'r1'
    施放赤疾风()
    return

  if group == 'r2'
    # 连攻
    delay '交剑'
    return

  if group == 'l1'
    施放赤烈风()
    return

$.on '2joy3', ->

  group = getGroup()
  if group == 'none'
    return

  索敌()
  
  if group == 'r1'
    施放赤闪雷()
    return

  if group == 'r2'
    # 焦热
    delay '能力技', 300, 2
    return

  if group == 'l1'
    施放赤震雷()
    return