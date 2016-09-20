#move to icon
moveToIcon = (name) ->
  delay 200
  findPic "D:\按键精灵\image\#{name}.bmp", x, y
  if x > 0 and y > 0
    moveTo x + 5, y + 5
  delay 200