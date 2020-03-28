$cd.技能施放判断间隔 = 100
$cd.技能施放补正 = 1500

# ---

$skill.飞石 = -> $.press 'alt + 1'
$skill.治疗 = -> $.press 'alt + 2'

# ---

$skill.疾风 = ->

  unless $isMoving

    if $level >= 72
      if hasStatusTarget '天辉'
        return
    else if $level >= 46
      if hasStatusTarget '烈风'
        return
    else
      if hasStatusTarget '疾风'
        return
  
  $.press 'alt + 3'
  return true

# ---

$skill.医治 = -> $.press 'alt + 4'
$skill.复活 = -> $.press 'alt + 5'
$skill.水流环 = -> $.press 'alt + 6'
$skill.救疗 = -> $.press 'alt + 7'

# ---

$skill.医济 = ->

  unless $level >= 50
    return
  
  if hasStatus '医济'
    return
  
  $.press 'alt + 8'
  return true

# ---

# include skill/神速咏唱

# ---

$skill.再生 = ->

  unless $level >= 35
    return
  
  if hasStatusTarget '再生'
    return

  unless 能力技冷却判断()
    return
  
  $.press 'alt + 0'
  return true

# ---

$skill.愈疗 = ->

  unless $level >= 40
    return

  $.press 'alt + minus'
  return true

# ---

$skill.神圣 = ->

  unless $level >= 45
    return
  
  $.press 'alt + equal'
  return true

# ---

$skill.天赐祝福 = ->

  unless $level >= 50
    return

  $.press 'ctrl + 1'
  return true

# ---

$skill.安慰之心 = ->

  unless $level >= 52
    return

  unless $white >= 1
    return

  unless 能力技冷却判断()
    return

  $.press 'ctrl + 2'
  return true

# ---

$skill.庇护所 = ->

  unless $level >= 52
    return

  $.press 'ctrl + 3'
  return true

# ---

# include skill/法令
# include skill/无中生有
# include skill/神名

# ---

$skill.神祝祷 = ->

  unless $level >= 66
    return

  $.press 'ctrl + 7'
  return true

# ---

# include skill/全大赦

# ---

$skill.苦难之心 = ->

  unless $level >= 74
    return

  unless $red >= 3
    return

  $.press 'ctrl + 9'
  return true

# ---

$skill.狂喜之心 = ->

  unless $level >= 76
    return

  unless $white >= 1
    return

  unless 能力技冷却判断()
    return

  $.press 'ctrl + 0'
  return true

# ---

$skill.节制 = ->

  unless $level >= 80
    return

  $.press 'ctrl + minus'
  return true

# ---

$skill.沉静 = -> $.press 'shift + 1'
$skill.康复 = -> $.press 'shift + 2'

# ---

# include skill/即刻咏唱
# include skill/醒梦

# ---

$skill.沉稳咏唱 = ->

  unless $level >= 44
    return
  
  $.press 'shift + 5'
  return true

# ---

$skill.营救 = ->

  unless $level >= 48
    return

  $.press 'shift + 6'
  return true

# ---

$skill.冲刺 = -> $.press 'shift + minus'
$skill.清空信息 = -> $.press 'shift + equal'

# ---

# include ../common/skill/中断咏唱
# include ../common/skill/索敌
# include skill/报告
# include skill/能力技
# include skill/获取状态