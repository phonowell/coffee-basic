d = {}

d.ask = ->
  d.value = prompt 'input value', d.ask

d.show = ->
  alert d.value

$.on 'alt + f2', ->
  d.show()