# use admin
# include binding
# include ../common/function/*
# include function/*
# include ../common/skill/*
# include skill/*

# ---

attackS = ->

  unless $isTargeting
    use '索敌'
    return

  if use '圣灵'
    return
  
  unless $isNear
    $.beep()
    return

  for skill in [
    '先锋剑'
    '暴乱剑'
    '沥血剑'
    '战女神之怒'
  ]

    if use skill
      use '能力技'
      break

# ---

attackM = ->

  if use '圣环'
    return

  for skill in [
    '全蚀斩'
    '日珥斩'
  ]

    if use skill
      use '能力技'
      break

# ---

attackF = ->

  unless $isTargeting
    use '索敌'
    return
  
  use '投盾'

# ---

defendS = ->

  unless $isTargeting
    return

  for skill in [
    '铁壁'
    '预警'
    '盾阵'
  ]
    if use skill
      return
  
  $.beep()

# ---

breakS = ->

  unless $isTargeting
    return

  for skill in [
    '下踢'
    '插言'
  ]
    if use skill
      return

  $.beep()

# ---

healS = ->

  for skill in [
    '圣光幕帘'
    '深仁厚泽'
  ]
    if use skill
      return
  
  $.beep()