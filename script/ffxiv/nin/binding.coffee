# include ../common/binding

# ---

attack = ->

  trigger = getCurrentTrigger()
  unless trigger
    return

  use '获取状态'
  use '报告'

  if trigger == 'right'
    attackS()
    return

  if trigger == 'both'
    attackM()
    return

  if trigger == 'left'
    attackF()
    return

bindAttack = ->

  isPressing = $.isPressing '2-joy-4'
  unless isPressing
    clearInterval bindAttack
    return

  attack()

$.on '2-joy-4', ->

  unless getCurrentTrigger()
    return

  clearInterval bindAttack
  setInterval bindAttack, 300
  attack()

# ---

$.on '2-joy-2', ->

  trigger = getCurrentTrigger()
  unless trigger
    return

  if trigger == 'right'
    defendS()
    return

# ---

$.on '2-joy-1', ->

  trigger = getCurrentTrigger()
  unless trigger
    return

  if trigger == 'right'
    breakS()
    return

  if trigger == 'both'
    breakH()
    return

# ---

# $.on '2-joy-3', ->

#   trigger = getCurrentTrigger()
#   unless trigger
#     return

#   if trigger == 'right'
#     healS()
#     return