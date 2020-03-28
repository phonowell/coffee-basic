# reload
$.on 'f5', ->
  resetKey()
  resetTs()
  $.beep()
  setLevel()

# reload without cache
$.on 'ctrl + f5', ->
  resetKey()
  $.beep()
  $.reload()

# exit
$.on 'alt + f4', ->
  resetKey()
  $.beep()
  $.exit()

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

# ---

toggleView = ->

  isPressing = $.isPressing '2-joy-5'
  unless isPressing
    clearInterval toggleView
    $.press 'ctrl:up', 'up:up'
    return

  state = $.getState '2-joy-r'
  if state < 20
    $.press 'ctrl:down', 'up:down'

$.on '2-joy-5', ->
  unless getGroup() == 'both'
    clearInterval toggleView
    setInterval toggleView, 300
    return
  $.press 'shift + tab'

$.on '2-joy-6', ->
  unless getGroup() == 'both'
    return
  $.press 'tab'

$.on '2-joy-12', ->
  unless getGroup()
    return
  use '冲刺'