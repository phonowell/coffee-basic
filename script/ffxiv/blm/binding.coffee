$.on 'f2', -> toggleView()

$.on 'f4', ->
  isReporting = !isReporting
  if !isReporting
    $.tip()

$.on 'f5', ->
  $.beep()
  $.reload()

$.on 'f6', ->
  [x, y] = $.getPosition()
  color = $.getColor x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'f9', ->
  [x, y] = $.findColor '#58483e'
  $.move x, y
  $.tip "#{x}, #{y}"

$.on 'f10', ->
  $.beep()
  $.exit()

# ---

isDotEnabled = true
$.on '2-joy-13', ->
  isDotEnabled = !isDotEnabled
  $.beep()

# ---

攻击 = ->

  group = getGroup()

  unless group
    return

  report()
  use '索敌'

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