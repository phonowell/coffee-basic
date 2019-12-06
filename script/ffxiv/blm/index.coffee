# use admin
# include ../common/function
# include binding
# include function
# include skill

# ---

单体攻击 = ->

  if isChanting()
    return

  if isMoving()
    即刻咏唱()

  if 闪雷()
    return

  checkMp()
  checkElement()

  if isMpLacking
    
    if element == 'fire'
      星灵移位()
      return
    
    冰结()
    return
  
  if element == 'ice'
    星灵移位()
    return

  火炎()
  return

# ---

群体攻击 = ->
  
  if isChanting()
    return

  if isMoving()
    即刻咏唱()

  if 震雷()
    return

  checkMp()
  checkElement()

  if isMpLacking
    
    if element == 'fire'
      星灵移位()
      return
    
    冰冻()
    return
  
  if element == 'ice'
    星灵移位()
    return

  烈炎()
  return

# ---

$.setTimeout 清空信息, 3e3