$.on 'f2', -> toggleView()

$.on 'f4', ->
  isReporting = !isReporting
  if !isReporting
    $.tip()

$.on 'f5', ->
  $.beep()
  $.reload()

$.on 'f9', ->
  [x, y] = $.getPosition()
  color = $.getColor x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'f6', ->
  [x, y] = $.findColor '#58483e'
  $.move x, y
  $.tip "#{x}, #{y}"

$.on 'f12', ->
  $.beep()
  $.exit()

# ---

攻击 = ->

  group = getGroup()

  unless group
    return

  report()
  索敌()

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