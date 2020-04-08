hasStatusByTarget = (name) ->
  [x, y] = $.findImage "image/#{name}.png", 725, 765, 925, 800
  return x > 0 and y > 0