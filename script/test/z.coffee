d = {}

d.value = 2
d.display = ->
  unless d.value == 0 then return
  unless d.value > 1 then d.value = 1
  if d.value == -1 then d.value = -2 else d.value = 0
  alert d.value

$.on 'f1', -> fn()
