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
  # x = 650
  # y = 65
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

_治疗 = ->

  group = getGroup()

  unless group
    return

  report()

  # 单体治疗
  if group == 'right'
    单体治疗()
    return

  # 群体治疗
  if group == 'both'
    群体治疗()
    return

绑定治疗 = ->

  isPressing = $.isPressing '2-joy-2'
  unless isPressing
    $.clearInterval 绑定治疗
    $.setTimeout 清空信息, 10e3
    return

  $.clearTimeout 清空信息
  _治疗()

$.on '2-joy-2', ->

  unless getGroup()
    return

  $.clearInterval 绑定治疗
  $.setInterval 绑定治疗, 300
  _治疗()

# ---

$.on '2-joy-1', ->

  group = getGroup()

  unless group
    return

  # 护盾
  if group == 'right'
    神祝祷()
    return

  # 驱散
  if group == 'both'
    康复()
    return

  # 复活
  if group == 'left'
    即刻咏唱()
    无中生有()
    复活()
    return

# ---
  
$.on '2-joy-3', ->

  group = getGroup()
  
  unless group
    return

  if group == 'right'
    庇护所()
    return

  if group == 'both'
    无中生有()
    愈疗()
    return