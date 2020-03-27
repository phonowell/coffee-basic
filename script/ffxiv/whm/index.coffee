# use admin
# include ../common/function
# include binding
# include function
# include report
# include skill

# ---

$level = 80
ts = {}
cd = {}

# ---

attackS = ->

  if isChanting()
    return

  醒梦()
  法令()
  苦难之心()
  神速咏唱()

  if isMoving()
    疾风()
    return

  疾风()
  飞石()

attackM = ->

  if isChanting()
    return

  醒梦()
  法令()
  苦难之心()
  神速咏唱()
  无中生有()
  即刻咏唱()

  if isMoving()
    疾风()
    return

  神圣()

# ---

单体治疗 = ->

  if isChanting()
    return

  醒梦()
  法令()
  神名()
  安慰之心()
  再生()
  救疗()
  治疗()

群体治疗 = ->

  if isChanting()
    return

  醒梦()
  法令()
  全大赦()
  狂喜之心()
  医济()
  医治()