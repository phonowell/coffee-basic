# include ../common/binding

# ---

attack = ->

  group = getGroup()
  unless group
    return

  use '获取状态'
  use '报告'

  unless use '索敌'
    return

  if group == 'right'
    attackS()
    return

  if group == 'both'
    attackM()
    return

  if group == 'left'
    use '投盾'
    return

bindAttack = ->

  isPressing = $.isPressing '2-joy-4'
  unless isPressing
    clearInterval bindAttack
    return

  attack()

$.on '2-joy-4', ->

  unless getGroup()
    return

  clearInterval bindAttack
  setInterval bindAttack, 300
  attack()

# ---

$.on '2-joy-2', ->

  group = getGroup()
  unless group
    return

  if group == 'right'
    defendS()
    return

# ---

$.on '2-joy-1', ->

  group = getGroup()
  unless group
    return

  if group == 'right'
    breakS()
    return

# ---

$.on '2-joy-3', ->

  group = getGroup()
  unless group
    return

  if group == 'right'
    healS()
    return