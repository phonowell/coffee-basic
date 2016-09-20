#getItemByImage
getItemByImage = (name, count) ->
  delay 200
  isie = isImageExist name
  if isie == true
    if count == 1
      divideOne()
    else
      leftClick 1
    delay 200

#divide one
divideOne = ->
  delay 200
  keyDown 'Shift', 1
  delay 200
  leftClick 1
  delay 200
  keyUp 'Shift', 1
  delay 200
  keyDown 'Enter', 1
  delay 200