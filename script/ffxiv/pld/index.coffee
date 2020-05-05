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

  if use '先锋剑'
    use '能力技'
    return
  
  if use '暴乱剑'
    use '能力技'
    return

  if use '沥血剑'
    use '能力技'
    return
  
  if use '战女神之怒'
    use '能力技'
    return

# ---

attackM = ->
  
  if use '全蚀斩'
    use '能力技'
    return

  if use '日珥斩'
    use '能力技'
    return

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

  if use '铁壁' then return
  if use '预警' then return
  if use '盾阵' then return
  
  $.beep()

# ---

breakS = ->

  unless $isTargeting
    return

  if use '下踢' then return
  if use '插言' then return

  $.beep()

# ---

healS = ->
  
  if use '圣光幕帘' then return
  if use '深仁厚泽' then return
  
  $.beep()