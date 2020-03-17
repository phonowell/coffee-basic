# fix
$.on 'f2', ->
  $.beep()
  $.setFixed()

# reload
$.on 'f5', ->
  resetKey()
  $.beep()
  $.reload()

# exit
$.on 'alt + f4', ->
  resetKey()
  $.beep()
  $.exit()