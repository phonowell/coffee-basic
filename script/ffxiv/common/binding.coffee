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

$.on '2-joy-12', ->
  
  unless checkTrigger()
    return
  
  use '冲刺'