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
  $.send 'esc'

# function

attackA = ->
  $.send 'c'
  $.sleep 20
  $.send 'numpad4'
  $.sleep 20
  $.send 'numpad2'
  $.sleep 20
  $.send 'numpad6'
  $.sleep 20
  $.send 'numpad8'
  $.sleep 20
  $.send 'z'
  $.sleep 200
  $.send 'up'
  $.sleep 200
  $.send 'esc'
  $.sleep 600
  $.send 'esc'