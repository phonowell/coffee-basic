# use admin
# include ../common/function
# include binding
# include function
# include skill

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
  use '法令'
  use '神名'
  use '安慰之心'
  use '再生'
  use '救疗'
  use '治疗'

healM = ->

  if $isChanting
    return

  use '醒梦'
  use '法令'
  use '全大赦'
  use '狂喜之心'
  use '医济'
  use '医治'