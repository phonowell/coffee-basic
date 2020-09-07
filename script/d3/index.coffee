# variable

tsClickLeft = 0

# function

fnTest = -> $.beep()

checkLeft = ->
  if $.now() - tsClickLeft > 1e3
    $.press 'space'

# binding

$.on 'f11', -> $.reload()
$.on 'f12', -> $.exit()

$.on 'f1', ->
  $.move 100, 100
  $.click()

$.on 'left-click', ->
  tsClickLeft = $.now()
  setInterval 'checkLeft', 300

$.on 'left-click:up', ->
  clearInterval 'checkLeft'
  if $.now() - tsClickLeft > 1e3
    $.press 'space:up'