hasUsed = (name) ->

  [x, y] = $.findImage "image/#{name}.png", 60, 915, 225, 975
  
  if x > 0 and y > 0
    return true
  return false