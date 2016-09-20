#caution: type 1
#cursor shape
cursorShape = (name) =>
  switch name
    when 'default'
      return 2147483647
    when 'forbiden'
      return 2147409951
    when 'point'
      return 252698368
    when 'input'
      return 2113994751
    when 'Hand'
      return 961150971
    when 'drop'
      return 961085563
    when 'fire'
      return 1576667162
    when 'riot'
      return 1027735296
    when 'hammer'
      return 2130706431
    else
      return GetCursorShape(1)