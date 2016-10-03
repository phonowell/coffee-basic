#caution: type 1

#get shape
$.getShape = =>
  _shape = GetCursorShape 1
  return _shape

#cursor shape
$.shape = (_name) =>
  switch _name
    when 'default'
      _shape = 2147483647
    when 'blade'
      _shape = 2081579103
    when 'range'
      _shape = 1075777535
    when 'range-out'
      _shape = 1011269659
    when 'forbiden'
      _shape = 2147409951
    when 'point'
      _shape = 252698368
    when 'input'
      _shape = 2113994751
    when 'hand'
      _shape = 961150971
    when 'drop'
      _shape = 961085563
    when 'fire'
      _shape = 1576667162
    when 'riot'
      _shape = 1027735296
    when 'hammer'
      _shape = 2130706431
  return _shape

#is shape
$.isShape = (_name) =>
  _current = $.getShape()
  _target = $.shape _name
  if _current == _target
    return true
  else
    return false