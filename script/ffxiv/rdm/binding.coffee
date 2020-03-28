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

attackX = ->

  group = getGroup()
  unless group
    return

  use '获取状态'
  use '报告'

  unless use '索敌'
    return

  # 魔三连
  if group == 'right'
    unless use '魔三连'
      attackS()
      return
    use '能力技'
    return

  if group == 'both'
    unless use '魔划圆斩'
      attackM()
      return
    use '能力技'
    return

bindAttackX = ->

  isPressing = $.isPressing '2-joy-2'
  unless isPressing
    clearInterval bindAttackX
    return

  attackX()

$.on '2-joy-2', ->

  unless getGroup()
    return

  clearInterval bindAttackX
  setInterval bindAttackX, 300
  attackX()

# ---

heal = ->

  group = getGroup()
  unless group
    return

  use '获取状态'
  use '报告'

  # 单体治疗
  if group == 'right'
    healS()
    return

  # 复活
  if group == 'both'
    revive()
    return

bindHeal = ->

  isPressing = $.isPressing '2-joy-3'
  unless isPressing
    clearInterval bindHeal
    return

  heal()

$.on '2-joy-3', ->

  unless getGroup()
    return

  clearInterval bindHeal
  setInterval bindHeal, 300
  heal()