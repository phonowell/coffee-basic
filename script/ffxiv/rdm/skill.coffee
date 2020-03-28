$cd.技能施放判断间隔 = 100
$cd.技能施放补正 = 1500
$cd.comboZ = 15e3

# ---

# include skill/回刺

# ---

$skill.摇荡 = -> $.press 'alt + 2'

# ---

$skill.赤闪雷 = ->
  $.press 'alt + 3'
  $ts.赤疾风 = A_TickCount

# ---

# include skill/短兵相接

# ---

$ts.赤疾风 = 0
$skill.赤疾风 = ->
  $.press 'alt + 5'
  $ts.赤疾风 = A_TickCount

# ---

$skill.散碎 = -> $.press 'alt + 6'
$skill.赤震雷 = -> $.press 'alt + 7'
$skill.赤烈风 = -> $.press 'alt + 8'
$skill.赤火炎 = -> $.press 'alt + 9'
$skill.赤飞石 = -> $.press 'alt + 0'

# ---

# include skill/交击斩

# ---

$skill.移转 = ->

  unless $level >= 40
    return

  $.press 'alt + equal'
  return true

# ---

# include skill/飞刺
# include skill/连攻
# include skill/促进

# ---

$skill.划圆斩 = ->

  unless $level >= 52
    return

  unless $black >= 20 and $white >= 20
    return

  $distance = getDistance()
  unless $distance == 'near'
    use '短兵相接', true
    return

  $.press 'ctrl + 4'
  return true

# ---

$skill.赤治疗 = ->

  unless $level >= 54
    return

  $.press 'ctrl + 5'
  return true

# ---

# include skill/六分反击
# include skill/鼓励
# include skill/倍增

# ---

$skill.赤复活 = ->

  unless $level >= 64
    return

  $.press 'ctrl + 9'
  return true

# ---

# include skill/交剑

# ---

$skill.续斩 = ->

  unless $level >= 76
    return
  
  $.press 'ctrl + minus'
  return true

# ---

$skill.昏乱 = -> $.press 'shift + 1'

# ---

# include skill/即刻咏唱
# include skill/醒梦

# ---

$skill.沉稳咏唱 = ->

  unless $level >= 44
    return

  $.press 'shift + 4'
  return true

# ---

$skill.冲刺 = -> $.press 'shift + minus'
$skill.清空信息 = -> $.press 'shift + equal'
  
# ---

# include ../common/skill/中断咏唱
# include ../common/skill/索敌
# include skill/报告
# include skill/焦热
# include skill/能力技
# include skill/获取状态
# include skill/调整魔元
# include skill/赤神圣
# include skill/魔三连
# include skill/魔划圆斩