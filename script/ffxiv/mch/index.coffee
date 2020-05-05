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
    $.beep()
    return

  if $isOverheat
    use '热冲击'
    use '能力技'
    return

  for skill in [
    '热弹'
    '分裂弹'
    '独头弹'
    '狙击弹'
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

  if use '散射'
    use '能力技'
    return