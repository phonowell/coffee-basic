delay = (name, time = 300, n = 1) ->
  $.loop n, ->
    if n != 1
      await $.sleep time
    $.clearTimeout name
    $.setTimeout name, time

getGroup = ->

  isLT = $.isPressing '2-joy-7'
  isRT = $.isPressing '2-joy-8'

  if isLT and isRT
    return 'both'

  if isLT
    return 'left'

  if isRT
    return 'right'

  return false

hasStatus = (name) ->

  [x, y] = $.findImage "image/#{name}.png", 725, 840, 925, 875
  
  if x > 0 and y > 0
    return true
  return false

isChanted = (name) ->

  [x, y] = $.findImage "image/#{name}.png", 20, 885, 285, 975
  
  if x > 0 and y > 0
    return true
  return false

isChanting = ->
  color = $.getColor 1010, 620
  return color == 0x2B1B13

isMoving = ->

  dis = $.getState '2-joy-x'
  if dis < 40
    return true
  if dis > 60
    return true

  dis = $.getState '2-joy-y'
  if dis < 40
    return true
  if dis > 60
    return true

  return false

isViewFar = false
toggleView = ->

  if isViewFar == false

    $.press 'ctrl:down', 'up:down', 'page-down:down'
    await $.sleep 3e3
    $.press 'ctrl:up', 'up:up', 'page-down:up'

    isViewFar = true

  else

    $.press 'ctrl:down', 'down:down', 'page-up:down'
    await $.sleep 3e3
    $.press 'ctrl:up', 'down:up', 'page-up:up'

    isViewFar = false

  $.beep()