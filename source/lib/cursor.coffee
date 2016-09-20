#caution: type 1
#cursor shape
cursorShape = (name) =>
  switch name
    when 'default'
      cursorShape = 2147483647
    when 'forbiden'
      cursorShape = 2147409951
    when 'point'
      cursorShape = 252698368
    when 'input'
      cursorShape = 2113994751
    when 'Hand'
      cursorShape = 961150971
    when 'drop'
      cursorShape = 961085563
    when 'fire'
      cursorShape = 1576667162
    when 'riot'
      cursorShape = 1027735296
    when 'hammer'
      cursorShape = 2130706431
    else
      cursorShape = GetCursorShape(1)