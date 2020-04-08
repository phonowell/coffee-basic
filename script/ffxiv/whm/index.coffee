# use admin
# include binding
# include ../common/function/*
# include function/*
# include ../common/skill/*
# include skill/*

# ---

attackS = ->

  if $isChanting
    return

  use '醒梦'
  use '法令'
  use '苦难之心'
  use '神速咏唱'

  if $isMoving
    use '疾风'
    return

  use '疾风'
  use '飞石'

attackM = ->

  if $isChanting
    return

  use '醒梦'
  use '法令'
  use '苦难之心'
  use '神速咏唱'
  use '无中生有'
  use '即刻咏唱'

  if $isMoving
    use '疾风'
    return

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
  if use '治疗' then return

  $.beep()

healM = ->

  if $isChanting
    return

  use '醒梦'

  if use '法令' then return
  if use '全大赦' then return
  if use '狂喜之心' then return
  if use '医济' then return
  if use '愈疗' then return
  if use '医治' then return
  
  $.beep()