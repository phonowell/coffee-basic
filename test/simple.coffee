# exit
$.on 'f1', ->
  $.exit()

# bind

$.on 'joy4', ->
  $.block true
  attackC()
  $.block false

$.on 'joy5', ->
  $.block true
  attackB()
  $.block false

$.on 'joy6', ->
  $.block true
  attackA()
  $.block false

$.on 'joy7', ->
  $.press 'esc'

# function

attackA = ->
  $.press 'c'
  $.sleep 20
  $.press 'numpad4'
  $.sleep 20
  $.press 'numpad2'
  $.sleep 20
  $.press 'numpad6'
  $.sleep 20
  $.press 'numpad8'
  $.sleep 20
  $.press 'z'
  $.sleep 200
  $.press 'up'
  $.sleep 200
  $.press 'esc'
  $.sleep 600
  $.press 'esc'

attackB = ->
  $.press 'numpad4'
  $.sleep 20
  $.press 'numpad8'
  $.sleep 20
  $.press 'numpad6'
  $.sleep 20
  $.press 'numpad2'
  $.sleep 20
  $.press 'z'

attactC = ->
  $.press 'z-down'
  $.press 'x'
  $.press 'z-up'