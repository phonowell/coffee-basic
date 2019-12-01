$.on 'f12', ->
  $.beep()
  $.exit()

$.on 'f6', ->
  [x, y] = $.getPosition()
  color = $.getColor x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'f7', ->
  white = getWhite()
  black = getBlack()
  $.tip "#{white} / #{black}"

$.on 'f8', ->
  x = 1100
  y = 935
  color = $.getColor x, y
  $.tip "#{x}, #{y}, #{color}"

$.on 'f2', ->
  toggleView()

# ---

$.on '2-joy-4', ->
  $.loop ->

    isPressing = $.isPressing '2-joy-4'
    unless isPressing
      break

    攻击()

    await $.sleep 300

$.on '2-joy-2', ->
  $.loop ->

    isPressing = $.isPressing '2-joy-2'
    unless isPressing
      break

    特殊攻击()

    await $.sleep 300

$.on '2-joy-1', ->

  group = getGroup()

  if group == 'right'
    
    if hasStatus '连续咏唱'
      $.beep()
      return
    
    索敌()
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