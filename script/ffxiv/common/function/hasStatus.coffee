hasStatus = (name) ->
  [x, y] = $.findImage "image/#{name}.png", 725, 840, 925, 875
  return x > 0 and y > 0