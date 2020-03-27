# toggle view
$.on 'f2', -> toggleView()

# hide message
$.on 'f4', ->
  isReporting = !isReporting
  if isReporting
    report()
  else
    $.tip()

# reload
$.on 'f5', ->
  清空信息()
  resetKey()
  $.beep()
  $.reload()

# exit
$.on 'alt + f4', ->
  $.beep()
  resetKey()
  $.exit()

# ---

攻击 = ->

  group = getGroup()

  unless group
    return

  report()
  
  unless use '索敌'
    return

  # attackS
  if group == 'right'
    attackS()
    return

  # attackM
  if group == 'both'
    attackM()
    return

bindAttack = ->

  isPressing = $.isPressing '2-joy-4'
  unless isPressing
    $.clearInterval bindAttack
    $.setTimeout 清空信息, 5e3
    return

  $.clearTimeout 清空信息
  攻击()

$.on '2-joy-4', ->

  unless getGroup()
    return

  $.clearInterval bindAttack
  $.setInterval bindAttack, 300
  攻击()

# ---

$.on '2-joy-5', ->
  unless getGroup() == 'both'
    return
  $.press 'shift + tab'

$.on '2-joy-6', ->
  unless getGroup() == 'both'
    return
  $.press 'tab'

$.on '2-joy-12', ->
  unless getGroup()
    return
  冲刺()