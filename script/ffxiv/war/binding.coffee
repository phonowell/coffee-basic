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
  reset()
  $.beep()
  $.reload()

# exit
$.on 'alt + f4', ->
  $.beep()
  reset()
  $.exit()

# ---

攻击 = ->

  group = getGroup()

  unless group
    return

  report()
  
  unless 索敌()
    return

  # 单体攻击
  if group == 'right'
    单体攻击()
    return

  # 群体攻击
  if group == 'both'
    群体攻击()
    return

绑定攻击 = ->

  isPressing = $.isPressing '2-joy-4'
  unless isPressing
    $.clearInterval 绑定攻击
    $.setTimeout 清空信息, 5e3
    return

  $.clearTimeout 清空信息
  攻击()

$.on '2-joy-4', ->

  unless getGroup()
    return

  $.clearInterval 绑定攻击
  $.setInterval 绑定攻击, 300
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