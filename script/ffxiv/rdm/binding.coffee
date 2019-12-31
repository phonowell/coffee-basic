$.on 'f2', -> toggleView()

$.on 'f4', ->
  isReporting = !isReporting
  if isReporting
    report()
  else
    $.tip()

$.on 'f5', ->
  清空信息()
  reset()
  $.beep()
  $.reload()

$.on 'f6', ->
  [x, y] = $.findColor '#58483e'
  $.move x, y
  $.tip "#{x}, #{y}"

$.on 'f9', ->
  [x, y] = $.getPosition()
  color = $.getColor x, y
  # $.move x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'f10', ->
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
    $.setTimeout 清空信息, 10e3
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

特殊攻击 = ->

  group = getGroup()

  unless group
    return

  report()

  unless 索敌()
    return

  if group == 'right'
    魔三连()
    return

  if group == 'both'
    魔划圆斩()
    return

绑定特殊攻击 = ->

  isPressing = $.isPressing '2-joy-2'
  unless isPressing
    $.clearInterval 绑定特殊攻击
    $.setTimeout 清空信息, 5e3
    return

  $.clearTimeout 清空信息
  特殊攻击()

$.on '2-joy-2', ->

  unless getGroup()
    return

  $.clearInterval 绑定特殊攻击
  $.setInterval 绑定特殊攻击, 300
  特殊攻击()

# ---

治疗 = ->

  group = getGroup()

  unless group
    return

  report()

  # 治疗
  if group == 'right'
    单体治疗()
    return

  # 复活
  if group == 'both'
    复活()
    return

绑定治疗 = ->

  isPressing = $.isPressing '2-joy-3'
  unless isPressing
    $.clearInterval 绑定治疗
    $.setTimeout 清空信息, 10e3
    return

  $.clearTimeout 清空信息
  治疗()

$.on '2-joy-3', ->

  unless getGroup()
    return

  $.clearInterval 绑定治疗
  $.setInterval 绑定治疗, 300
  治疗()

# ---

$.on '2-joy-5', ->
  
  unless getGroup() == 'both'
    return

  $.press 'shift + tab'

$.on '2-joy-6', ->

  unless getGroup() == 'both'
    return

  $.press 'tab'