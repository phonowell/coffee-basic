cd.技能施放判断间隔 = 100
cd.技能施放补正 = 1500

# ---

飞石 = -> $.press 'alt + 1'
治疗 = -> $.press 'alt + 2'

# ---

疾风 = ->

  unless isMoving()

    if level >= 72
      if hasStatusTarget '天辉'
        return false
    else if level >= 46
      if hasStatusTarget '烈风'
        return false
    else
      if hasStatusTarget '疾风'
        return false
  
  $.press 'alt + 3'
  return true

# ---

医治 = -> $.press 'alt + 4'
复活 = -> $.press 'alt + 5'
水流环 = -> $.press 'alt + 6'
救疗 = -> $.press 'alt + 7'

# ---

医济 = ->

  unless level >= 50
    return false
  
  if hasStatus '医济'
    return false
  
  $.press 'alt + 8'
  return true

# ---

# include skill/神速咏唱

# ---

再生 = ->

  unless level >= 35
    return false
  
  if hasStatusTarget '再生'
    return false

  unless 能力技冷却判断()
    return false
  
  $.press 'alt + 0'
  return true

# ---

愈疗 = ->

  unless level >= 40
    return false

  $.press 'alt + minus'
  return true

# ---

神圣 = ->

  unless level >= 45
    return false
  
  $.press 'alt + equal'
  return true

# ---

天赐祝福 = ->

  unless level >= 50
    return false

  $.press 'ctrl + 1'
  return true

# ---

安慰之心 = ->

  unless level >= 52
    return false

  unless white >= 1
    return false

  unless 能力技冷却判断()
    return false

  $.press 'ctrl + 2'
  return true

# ---

庇护所 = ->

  unless level >= 52
    return false

  $.press 'ctrl + 3'
  return true

# ---

# include skill/法令
# include skill/无中生有
# include skill/神名

# ---

神祝祷 = ->

  unless level >= 66
    return false

  $.press 'ctrl + 7'
  return true

# ---

# include skill/全大赦

# ---

苦难之心 = ->

  unless level >= 74
    return false

  unless red >= 3
    return false

  $.press 'ctrl + 9'
  return true

# ---

狂喜之心 = ->

  unless level >= 76
    return false

  unless white >= 1
    return false

  unless 能力技冷却判断()
    return false

  $.press 'ctrl + 0'
  return true

# ---

节制 = ->

  unless level >= 80
    return false

  $.press 'ctrl + minus'
  return true

# ---

沉静 = -> $.press 'shift + 1'
康复 = -> $.press 'shift + 2'

# ---

# include skill/即刻咏唱
# include skill/醒梦

# ---

沉稳咏唱 = ->

  unless level >= 44
    return false
  
  $.press 'shift + 5'
  return true

# ---

营救 = ->

  unless level >= 48
    return false

  $.press 'shift + 6'
  return true

# ---

冲刺 = -> $.press 'shift + minus'
清空信息 = -> $.press 'shift + equal'

# ---

# include ../common/skill/索敌
# include ../common/skill/中断咏唱
# include skill/能力技