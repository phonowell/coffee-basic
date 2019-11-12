# variable

isLeftPressed = false
isRightPressed = false

# function

jump = ->
  $.press 'space'

viewFar = ->
  $.press 'ctrl:down', 'up:down', 'page-up:down'
  $.sleep 5000
  $.press 'ctrl:up', 'up:up', 'page-down:up'

# bind

# exit
$.on 'f12', ->
  $.exit()

# test
$.on 'f1', ->
  viewFar()

# left

$.on 'click', ->
  isLeftPressed = true

  if isRightPressed == true
    jump()
    return

  $.click 'down'

$.on 'click:up', ->
  isLeftPressed = false
  $.click 'up'

# right

$.on 'click-right', ->
  isRightPressed = true

  if isLeftPressed == true
    jump()
    return

  $.click 'right', 'down'

$.on 'click-right:up', ->
  isRightPressed = false
  $.click 'right', 'up'