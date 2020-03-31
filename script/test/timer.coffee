$.on 'f5', ->
  $.beep()
  $.reload()

$.on 'alt + f4', ->
  $.beep()
  $.exit()

# ---

$.on 'f2', -> d.setTimer 'display'
$.on 'f4', -> d.clearTimer 'display'

# ---

d = {}

d.setTimer = (name) ->
  clearInterval d[name]
  setInterval d[name], 1e3

d.clearTimer = (name) -> clearInterval d[name]

d.display = -> $.tip A_TickCount