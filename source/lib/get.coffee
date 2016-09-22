#getItemByImage
getItemByImage = (name, count) ->
  findImage name
  if x > 0 and y > 0
    moveTo x + 5, y + 5
    delay 200
    if count == 1
      divideOne()
    else
      leftClick 1

#divide one
divideOne = ->
  keyDown 'Shift', 1
  delay 200
  leftClick 1
  delay 200
  keyUp 'Shift', 1
  delay 200
  keyDown 'Enter', 1