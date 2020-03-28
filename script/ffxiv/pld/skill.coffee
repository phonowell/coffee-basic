$cd.技能施放判断间隔 = 100
$cd.技能施放补正 = 1500

# ---

# include skill/先锋剑
# include skill/战逃反应
# include skill/暴乱剑
# include skill/全蚀斩

$skill.盾牌猛击 = -> $.press 'alt + 5'

$skill.钢铁信念 = -> $.press 'alt + 6'

$skill.投盾 = ->

  unless $level >= 15
    return

  $.press 'alt + 7'
  return true

# include skill/战女神之怒

$skill.预警 = -> $.press 'alt + 9'

$skill.厄运流转 = -> $.press 'alt + 0'

# include skill/深奥之灵

# ---

$skill.铁壁 = -> $.press 'shift + 1'

$skill.下踢 = -> $.press 'shift + 2'

$skill.挑衅 = -> $.press 'shift + 3'

$skill.插言 = -> $.press 'shift + 4'

$skill.血仇 = -> $.press 'shift + 5'

$skill.亲疏自行 = -> $.press 'shift + 6'

$skill.退避 = -> $.press 'shift + 7'

# ---

$skill.冲刺 = -> $.press 'shift + minus'
$skill.空白信息 = -> $.press 'shift + equal'

# ---

# include ../common/skill/索敌
# include skill/报告
# include skill/能力技
# include skill/获取状态