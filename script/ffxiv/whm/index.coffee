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

  use '醒梦'
  use '法令'

  if use '苦难之心' then return
  
  use '神速咏唱'

  if use '疾风' then return
  use '飞石'

attackM = ->

  unless $isTargeting
    use '索敌'
    return

  if $isChanting
    return

  use '醒梦'
  use '法令'

  if use '苦难之心' then return

  use '神速咏唱'
  use '无中生有'
  use '即刻咏唱'

  use '神圣'

# ---

healS = ->

  if $isChanting
    return

  use '醒梦'

  if use '法令' then return
  if use '神名' then return
  if use '安慰之心' then return
  if use '再生' then return
  if use '救疗' then return
  use '治疗'

healM = ->

  if $isChanting
    return

  use '醒梦'

  if use '法令' then return
  if use '全大赦' then return
  if use '狂喜之心' then return
  if use '医济' then return
  if use '愈疗' then return
  use '医治'