技能施放判断间隔 = 100
技能施放时间戳补正 = 1500
魔三连冷却 = 15e3

# ---

# include skill/回刺

# ---

摇荡 = -> $.press 'alt + 2'

# ---

赤闪雷 = ->
  $.press 'alt + 3'
  赤疾风时间戳 = A_TickCount

# ---

# include skill/短兵相接

# ---

赤疾风时间戳 = 0
赤疾风 = ->
  $.press 'alt + 5'
  赤疾风时间戳 = A_TickCount

# ---

散碎 = -> $.press 'alt + 6'
赤震雷 = -> $.press 'alt + 7'
赤烈风 = -> $.press 'alt + 8'
赤火炎 = -> $.press 'alt + 9'
赤飞石 = -> $.press 'alt + 0'

# ---

# include skill/交击斩

# ---

移转 = -> $.press 'alt + equal'

# ---

# include skill/飞刺
# include skill/连攻
# include skill/促进

# ---

划圆斩 = ->

  unless black >= 20 and white >= 20
    return false

  distance = getDistance()
  unless distance == 'near'
    短兵相接 true
    return false

  $.press 'ctrl + 4'
  return true

# ---

赤治疗 = -> $.press 'ctrl + 5'

# ---

# include skill/六分反击
# include skill/鼓励
# include skill/倍增

# ---

赤复活 = -> $.press 'ctrl + 9'

# ---

# include skill/交剑

# ---

续斩 = -> $.press 'ctrl + minus'
昏乱 = -> $.press 'shift + 1'

# ---

# include skill/即刻咏唱
# include skill/醒梦

# ---

沉稳咏唱 = -> $.press 'shift + 4'
冲刺 = -> $.press 'shift + minus'
清空信息 = -> $.press 'shift + equal'
  
# ---

# include skill/赤神圣
# include skill/焦热
# include ../common/skill/索敌
# include ../common/skill/中断咏唱
# include skill/能力技