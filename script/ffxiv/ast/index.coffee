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

  if $isChanting
    return

  for skill in [
    '醒梦'
    '光速'
    '抽卡'
  ]
    use skill

  for skill in [
    '烧灼'
    '凶星'
  ]
    if use skill
      return

attackM = ->

  unless $isTargeting
    use '索敌'
    return

  if $isChanting
    return

  for skill in [
    '醒梦'
    '光速'
    '抽卡'
  ]
    use skill

  for skill in [
    '重力'
  ]
    if use skill
      return

# ---

healS = ->

  if $isChanting
    return

  for skill in [
    '醒梦'
    '光速'
    '抽卡'
  ]
    use skill

  for skill in [
    '先天禀赋'
    '吉星相位'
    '福星'
    '吉星'
  ]
    if use skill
      return

healM = ->

  if $isChanting
    return

  for skill in [
    '醒梦'
    '光速'
    '抽卡'
  ]
    use skill

  for skill in [
    '阳星相位'
    '阳星'
  ]
    if use skill
      return