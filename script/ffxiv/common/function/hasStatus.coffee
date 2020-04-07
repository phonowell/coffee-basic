hasStatus = (name) ->

  [x, y] = $.findImage "image/#{name}.png", 725, 840, 925, 875
  
  if x > 0 and y > 0
    return true
  return false