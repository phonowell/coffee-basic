hasStatusByTarget = (name) ->

  [x, y] = $.findImage "image/#{name}.png", 725, 765, 925, 800
  
  if x > 0 and y > 0
    return true
  return false