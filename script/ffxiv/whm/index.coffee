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
    '法令'
    '苦难之心'
    '神速咏唱'
    '疾风'
    '飞石'
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
    '法令'
    '苦难之心'
    '神速咏唱'
    '无中生有'
    '即刻咏唱'
    '神圣'
  ]
    if use skill
      return

# ---

healS = ->

  if $isChanting
    return

  use '醒梦'

  for skill in [
    '法令'
    '神名'
    '安慰之心'
    '再生'
    '救疗'
    '治疗'
  ]
    if use skill
      return

healM = ->

  if $isChanting
    return

  use '醒梦'
  use '全大赦'

  for skill in [
    '法令'
    '狂喜之心'
    '医济'
    '愈疗'
    '医治'
  ]
    if use skill
      return