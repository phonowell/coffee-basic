# use admin

# variable

cacheH = ''
cacheV = ''
isLp = false
isPaused = false
isReady = false
isRp = false

# function

bind = ->
  cacheH = '-'
  cacheV = '-'
  execute()
  $.setInterval execute, 200

clearTip = ->
  $.tip()

execute = ->

  # get direction
  [x, y] = $.getPosition()
  dv = getDv y
  dh = getDh x, dv

  press dh, dv

getDh = (x, dv) ->

  dis = x - (A_ScreenWidth * 0.5)

  if dv == ''

    if dis < 0
      dh = 'left'
    else if dis > 0
      dh = 'right'
    else
      dh = ''

  else

    if dis < -160
      dh = 'left'
    else if dis > 160
      dh = 'right'
    else
      dh = ''
      dv = 'up'

  return dh

getDv = (y) ->

  dis = y - (A_ScreenHeight * 0.8)

  if dis < -120
    dv = 'up'
  else if dis > 0
    dv = 'down'
  else
    dv = ''

  return dv

press = (dh, dv) ->

  if cacheH == dh and cacheV == dv
    return
  cacheH = dh
  cacheV = dv
  
  reset()

  if dh == 'left'
    $.press 'a:down'
  else if dh == 'right'
    $.press 'd:down'

  if dv == 'up'
    $.press 'w:down'
  else if dv == 'down'
    $.press 's:down'

reset = ->
  $.press 'w:up'
  $.press 'a:up'
  $.press 's:up'
  $.press 'd:up'

toggle = ->

  if isPaused == true
    $.tip 'ON'
    isPaused = false
  else
    $.tip 'OFF'
    isPaused = true

  $.setTimeout clearTip, 1e3

unbind = ->
  $.clearInterval execute
  reset()

viewFar = ->
  
  $.tip 'wait...'
  
  $.press 'ctrl:down', 'up:down', 'page-down:down'
  $.sleep 3e3
  $.press 'ctrl:up', 'up:up', 'page-down:up'
  
  $.tip 'ON'
  $.setTimeout clearTip, 1e3

# bind

$.on 'f12', ->
  $.click 'up'
  $.click 'right:up'
  reset()
  $.beep()
  $.exit()

# left click

$.on 'click', ->
  
  isLp = true

  if isPaused == false and isRp == true
    unbind()
    $.click 'down'
    $.click 'right:down'
    return

  $.click 'down'

$.on 'click:up', ->
  
  isLp = false

  if isPaused == false and isRp == true
    $.click 'up'
    $.click 'right:up'
    bind()
    return
  
  $.click 'up'

# right click

$.on 'click-right', ->

  if isReady == false
    viewFar()
    isReady = true
    return

  isRp = true

  if isPaused == false and isLp == false
    bind()
    return

  $.click 'right:down'

$.on 'click-right:up', ->
  
  isRp = false

  if isPaused == false and isLp == false
    unbind()
    return
  
  $.click 'right:up'

# middle click

$.on 'click-middle', ->
  
  if isRp == true
    $.press 'space'
    return

  toggle()

$.on 'click-middle:up', ->
  $.click 'middle:up'

# execute

if A_YYYY != 2019
  $.exit()