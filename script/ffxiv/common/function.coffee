clearTip = -> $.tip()

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

hp = 0
getHp = ->
  [x, y] = $.findColor '#58483e', 21, 36, 168, 36, 10
  
  unless x
    return 100
  
  percent = (x - 21) * 100 / (168 - 21)
  percent = Math.floor percent
  return percent

mp = 0
getMp = ->
  [x, y] = $.findColor '#58483e', 181, 36, 328, 36, 10
  
  unless x
    return 100
  
  percent = (x - 181) * 100 / (328 - 181)
  percent = Math.floor percent
  return percent

hasStatus = (name) ->

  [x, y] = $.findImage "image/#{name}.png", 725, 840, 925, 875
  
  if x > 0 and y > 0
    return true
  return false

hasStatusTarget = (name) ->

  [x, y] = $.findImage "image/#{name}.png", 725, 765, 925, 800
  
  if x > 0 and y > 0
    return true
  return false

isUsed = (name) ->

  [x, y] = $.findImage "image/#{name}.png", 60, 915, 225, 975
  
  if x > 0 and y > 0
    return true
  return false

isChanting = ->
  color = $.getColor 1010, 612
  return color == 0x58483E

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