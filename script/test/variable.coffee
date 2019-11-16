# module/getGlobal

# simple

a = 1
b = 'string'
c = "#{a}, #{c}"
d = true
e = fn()
f = fn a, b

# inside function

inside = ->
  a = 1
  b = 'string'
  c = "#{a}, #{c}"
  d = true
  e = fn()
  f = fn a, b

# other

if a != true
  a = 1