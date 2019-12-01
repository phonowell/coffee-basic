# use admin
# include ../common/function
# include skill
# include function
# include binding

能力技 = ->
  索敌()
  倍增()
  飞刺()
  六分反击()
  交剑()
  昏乱()
  醒梦()

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

  if isChanting()
    return
  
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

  if isChanting()
    return

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
  $.beep()

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
      攻击()
      return
    
    索敌()
    划圆斩()
    delay '能力技'
    return