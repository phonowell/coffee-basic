# reload
$.on 'f5', ->
  resetKey()
  resetTs()
  $.beep()
  setLevel()

# reload without cache
$.on 'ctrl + f5', ->
  resetKey()
  $.beep()
  $.reload()

# exit
$.on 'alt + f4', ->
  resetKey()
  $.beep()
  $.exit()

# ---

toggleView = ->

  isPressing = $.isPressing '2-joy-5'
  unless isPressing
    clearInterval toggleView
    $.press 'ctrl:up', 'up:up'
    return

  state = $.getState '2-joy-r'
  if state < 20
    $.press 'ctrl:down', 'up:down'

$.on '2-joy-5', ->
  unless getCurrentTrigger() == 'both'
    clearInterval toggleView
    setInterval toggleView, 300
    return
  $.press 'shift + tab'

$.on '2-joy-6', ->
  unless getCurrentTrigger() == 'both'
    return
  $.press 'tab'

$.on '2-joy-12', ->
  unless getCurrentTrigger()
    return
  use '冲刺'