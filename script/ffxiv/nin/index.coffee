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
  
  unless $distance == 'near'
    return

  if use '影牙'
    use '能力技'
    return

  if use '双刃旋'
    use '能力技'
    return
  
  if use '绝风'
    use '能力技'
    return

  if use '旋风刃'
    use '能力技'
    return

# ---

attackM = ->

  if use '八卦无刃杀'
    use '能力技'
    return
  
  if use '血雨飞花'
    use '能力技'
    return

# ---

attackF = ->

  unless $isTargeting
    use '索敌'
    return
  
  use '飞刀'

# ---

defendS = ->
  
  if use '残影' then return
  if use '内丹' then return
  if use '浴血' then return
  
  $.beep()

# ---

breakS = ->

  unless $isTargeting
    return

  if use '扫腿' then return

  $.beep()

# ---

breakH = ->

  unless $isTargeting
    return

  if use '牵制' then return

  $.beep()