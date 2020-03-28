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

$.on '2-joy-2', ->

  group = getGroup()
  unless group
    return

  use '获取状态'
  use '报告'

  if group == 'right'
    healS()
    return

  if group == 'both'
    healM()
    return

# ---

$.on '2-joy-1', ->

  group = getGroup()
  unless group
    return

  use '获取状态'
  use '报告'

  # 护盾
  if group == 'right'
    use '神祝祷'
    return

  # 驱散
  if group == 'both'
    use '康复'
    return

  # 复活
  if group == 'left'
    use '即刻咏唱'
    use '无中生有'
    use '复活'
    return

# ---
  
$.on '2-joy-3', ->

  group = getGroup()
  unless group
    return

  use '获取状态'
  use '报告'

  if group == 'right'
    use '庇护所'
    return

  if group == 'both'
    use '无中生有'
    use '愈疗'
    return