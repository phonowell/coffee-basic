# include ../common/binding

# ---

attack = ->

  use '获取状态'
  use '报告'

  if $trigger == 'right'
    attackS()
    return

  if $trigger == 'both'
    attackM()
    return

bindAttack = ->

  isPressing = $.isPressing '2-joy-4'
  unless isPressing
    clearInterval bindAttack
    return

  attack()

$.on '2-joy-4', ->

  unless checkTrigger()
    return

  clearInterval bindAttack
  setInterval bindAttack, 300
  attack()

# ---

$.on '2-joy-2', ->

  use '获取状态'
  use '报告'

  if $trigger == 'right'
    healS()
    return

  if $trigger == 'both'
    healM()
    return

# ---

$.on '2-joy-1', ->

  use '获取状态'
  use '报告'

  # 护盾
  if $trigger == 'right'
    use '神祝祷'
    return

  # 驱散
  if $trigger == 'both'
    use '康复'
    return

  # 复活
  if $trigger == 'left'
    for skill in [
      '即刻咏唱'
      '无中生有'
      '复活'
    ]
      use skill
    return

# ---
  
$.on '2-joy-3', ->

  use '获取状态'
  use '报告'

  if $trigger == 'right'
    use '庇护所'
    return