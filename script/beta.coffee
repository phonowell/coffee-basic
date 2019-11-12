# function

beep = ->
  $.beep()

# bind

# exit
$.on 'f12', ->
  $.exit()

$.on 'f1', ->
  setTimeout beep, 1e3
  clearTimeout beep

$.on 'f2', ->
  setInterval beep, 1e3