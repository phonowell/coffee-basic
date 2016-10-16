#pick
$.pick = (_name) ->
  switch _name
    when '基础药草'
      _color = 'e1cad0'
    when '血红药草'
      _color = 'bbefd0'
    when '魔法药草'
      _color = 'e2f7d0'
    when '阳光药草'
      _color = 'd4a9d0'
    when '黄金药草'
      _color = 'fec0d0'
    when '羊毛'
      _color = 'c5d99f'

  $.findColor _color
  if x > 0
    $.use 'cancel', 'x'
    delay 200
    $.move x, y
    delay 200
    keyPress 'Alt', 1
    leftClick 1

    $.findColor _color
    if x > 0
      $.pick _name

#search
$.search = (_name) ->
  switch _name
    when '基础药草'
      _color = 'd9a6d0'
    when '血红药草'
      _color = 'e9a6d0'
    when '魔法药草'
      _color = 'd3a6d0'
    when '阳光药草'
      _color = 'fea6d0'
    when '金色药草'
      _color = 'baa6d0'