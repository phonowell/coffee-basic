fn = -> $.tip 'hello'

$.on 'f2', ->
  setTimeout fn, 1e3