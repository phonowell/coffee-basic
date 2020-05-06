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
    use '速行'
    return

  unless $isNear
    return

  for skill in [
    '直线射击'
    '风蚀箭'
    '毒咬箭'
    '强力射击'
  ]
    if use skill
      use '能力技'
      break

# ---

attackM = ->

  unless $isTargeting
    use '索敌'
    use '速行'
    return

  unless $isNear
    $.beep()
    return

  if use '连珠箭'
    use '能力技'
    return