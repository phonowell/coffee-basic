$.on 'f12', -> $.exit()

$.on 'f2', ->
  await $.sleep 1e3
  $.beep()

$.on 'f3', ->
  1