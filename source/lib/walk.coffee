#walk
$.walk = (_direction, _distance) ->
  if _direction == 'random'

    #check direction of x
    _dx = $.rnd -2, 1
    switch _dx
      when -1
        _dx = 'left'
      when 1
        _dx = 'right'
      else
        _dx = ''

    #check direction of y
    _dy = $.rnd -2, 1
    switch _dy
      when -1
        _dy = 'up'
      when 1
        _dy = 'down'
      else
        _dy = ''

    #walk!!
    if _dx == _dy
      _d = 'random'
    else
      _d = trim "#{_dx} #{_dy}"
    $.walk _d, _distance

  else

    #has got direction
    _time = 1000 * _distance
    switch _direction
      when 'left'
        keyDown 'a', 1
        delay _time
        keyUp 'a', 1
      when 'right'
        keyDown 'd', 1
        delay _time
        keyUp 'd', 1
      when 'up'
        keyDown 'w', 1
        delay _time
        keyUp 'w', 1
      when 'down'
        keyDown 's', 1
        delay _time
        keyUp 's', 1
      when 'left up'
        keyDown 'a', 1
        keyDown 'w', 1
        delay _time
        keyUp 'a', 1
        keyUp 'w', 1
      when 'left down'
        keyDown 'a', 1
        keyDown 's', 1
        delay _time
        keyUp 'a', 1
        keyUp 's', 1
      when 'right up'
        keyDown 'd', 1
        keyDown 'w', 1
        delay _time
        keyUp 'd', 1
        keyUp 'w', 1
      when 'right down'
        keyDown 'd', 1
        keyDown 's', 1
        delay _time
        keyUp 'd', 1
        keyUp 's', 1