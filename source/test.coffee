a = ->
  b = ->
    c = ->
      d = ->
        e = ->
          a = 3

if 2 > 1
  if 2 > 1
    if 2 > 1
      if 2 > 1
        if 2 > 1
          a = 1

if 2 > 1
  a = 1
  if 1 == 1
    b = 2
  else
    b = 5
else if 2 == 1
  a = 2
else
  a = 3

switch name
  when 'aaa'
    a = 'aaa'
  when 'bbb'
    a = 'bbb'
  when 'ccc'
    a = 'ccc'
  else
    a = 'ddd'

for i in [1...5]
  a = i + (1 - 2) / 3 * 4.3