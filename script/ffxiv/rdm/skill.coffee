cd.技能施放判断间隔 = 100
cd.技能施放补正 = 1500
cd.魔三连 = 15e3

# ---

# include skill/回刺

# ---

摇荡 = -> $.press 'alt + 2'

# ---

赤闪雷 = ->
  $.press 'alt + 3'
  ts.赤疾风 = A_TickCount

# ---

# include skill/短兵相接

# ---

ts.赤疾风 = 0
赤疾风 = ->
  $.press 'alt + 5'
  ts.赤疾风 = A_TickCount

# ---

散碎 = -> $.press 'alt + 6'
赤震雷 = -> $.press 'alt + 7'
赤烈风 = -> $.press 'alt + 8'
赤火炎 = -> $.press 'alt + 9'
赤飞石 = -> $.press 'alt + 0'

# ---

# include skill/交击斩

# ---

移转 = ->

  unless level >= 40
    return false

  $.press 'alt + equal'
  return true

# ---

# include skill/飞刺
# include skill/连攻
# include skill/促进

# ---

划圆斩 = ->

  unless level >= 52
    return false

  unless black >= 20 and white >= 20
    return false

  distance = getDistance()
  unless distance == 'near'
    短兵相接 true
    return false

  $.press 'ctrl + 4'
  return true

# ---

赤治疗 = ->

  unless level >= 54
    return false

  $.press 'ctrl + 5'
  return true

# ---

# include skill/六分反击
# include skill/鼓励
# include skill/倍增

# ---

赤复活 = ->

  unless level >= 64
    return false

  $.press 'ctrl + 9'
  return true

# ---

# include skill/交剑

# ---

续斩 = ->

  unless level >= 76
    return false
  
  $.press 'ctrl + minus'
  return true

# ---

昏乱 = -> $.press 'shift + 1'

# ---

# include skill/即刻咏唱
# include skill/醒梦

# ---

沉稳咏唱 = ->

  unless level >= 44
    return false

  $.press 'shift + 4'
  return true

# ---

冲刺 = -> $.press 'shift + minus'
清空信息 = -> $.press 'shift + equal'
  
# ---

# include skill/赤神圣
# include skill/焦热
# include ../common/skill/索敌
# include ../common/skill/中断咏唱
# include skill/能力技