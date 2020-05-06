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
  
  unless $isNear
    return

  for skill in [
    '影牙'
    '双刃旋'
    '绝风'
    '旋风刃'
  ]
    if use skill
      use '能力技'
      break

# ---

attackM = ->

  unless $isTargeting
    use '索敌'
    return

  for skill in [
    '血雨飞花'
    '八卦无刃杀'
  ]
    if use skill
      use '能力技'
      break

# ---

attackF = ->

  unless $isTargeting
    use '索敌'
    return
  
  use '飞刀'

# ---

defendS = ->

  for skill in [
    '残影'
    '内丹'
    '浴血'
  ]
    if use skill
      return
  
  $.beep()

# ---

breakS = ->

  unless $isTargeting
    return

  if use '扫腿'
    return

  $.beep()

# ---

breakH = ->

  unless $isTargeting
    return

  if use '牵制'
    return

  $.beep()