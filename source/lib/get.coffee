#get
$.get = (_name, _count) ->
  $.find _name
  if x > 0 and y > 0
    delay 200
    $.move x + 5, y + 5
    delay 500
    if _count == 1
      $.divide()
    else
      leftClick 1

#divide one
$.divide = ->
  keyDown 'Shift', 1
  delay 200
  leftClick 1
  delay 200
  keyUp 'Shift', 1
  delay 200
  keyDown 'Enter', 1