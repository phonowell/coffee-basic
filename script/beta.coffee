# use admin

$.on 'f12', ->
  $.exit()

$.on 'right-click', ->
  $.click 'right'
  $.loop 4, ->
    await $.sleep 100
    $.press 'num-0'