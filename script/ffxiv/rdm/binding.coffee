$.on 'f12', ->
  $.beep()
  $.exit()

$.on 'f5', ->
  [x, y] = $.getPosition()
  color = $.getColor x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'f2', ->
  toggleView()

$.on 'f3', ->
  isReporting = !isReporting
  if !isReporting
    $.tip()

# ---

攻击 = ->

  group = getGroup()

  unless group
    return

  索敌()
  魔元警告()

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
    $.setTimeout 清空信息, 3e3
    return

  $.clearTimeout 清空信息
  攻击()

$.on '2-joy-4', ->

  unless getGroup()
    return

  $.clearInterval 绑定攻击
  $.setInterval 绑定攻击, 350
  攻击()

# ---

特殊攻击 = ->

  group = getGroup()

  unless group
    return

  索敌()
  魔元警告()

  if group == 'right'
    魔三连()
    return

  if group == 'both'
    
    isA = hasStatus '连续咏唱'
    isB = hasStatus '即刻咏唱'
    if isA or isB
      攻击()
      asr = 2

    if 划圆斩()
      asr = 2
    else
      群体攻击()
      $.beep()

    短兵相接()
    能力技()
    return

绑定特殊攻击 = ->

  isPressing = $.isPressing '2-joy-2'
  unless isPressing
    $.clearInterval 绑定特殊攻击
    $.setTimeout 清空信息, 3e3
    return

  $.clearTimeout 清空信息
  特殊攻击()

$.on '2-joy-2', ->

  unless getGroup()
    return

  $.clearInterval 绑定特殊攻击
  $.setInterval 绑定特殊攻击, 350
  特殊攻击()

# ---

$.on '2-joy-1', ->

  group = getGroup()

  if group == 'right'
    
    isA = hasStatus '连续咏唱'
    isB = hasStatus '即刻咏唱'
    if isA or isB
      $.beep()
      return

    摇荡()
    delay '能力技'
    return

$.on '2-joy-3', ->

  group = getGroup()

  if group == 'right'
    赤治疗()
    return

  if group == 'both'
    赤复活()
    delay '能力技'
    return