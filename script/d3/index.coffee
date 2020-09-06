# variable

tsClickLeft = 0

# function

fnTest = ->
  unless use(a) then return 2

checkLeft = ->
  if $.now() - tsClickLeft > 1e3
    $.press 'space'

# binding

$.on 'f12', -> $.exit()

$.on 'left-click', ->
  tsClickLeft = $.now()
  setInterval 'checkLeft', 300

$.on 'left-click:up', ->
  clearInterval 'checkLeft'
  if $.now() - tsClickLeft > 1e3
    $.press 'space:up'