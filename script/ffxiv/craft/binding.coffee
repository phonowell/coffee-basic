# fix
$.on 'f2', ->
  $.beep()
  $.setFixed()

# reload
$.on 'f5', ->
  reset()
  $.beep()
  $.reload()

# exit
$.on 'alt + f4', ->
  reset()
  $.beep()
  $.exit()