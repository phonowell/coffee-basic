#get image position
getImagePosition = (name) ->
  findPic 0, 0, screenWidth, screenHeight, "D:\按键精灵\image\#{name}.bmp", 0.9, x, y

#move to image
moveToImage = (name) ->
  delay 200
  getImagePosition name
  if x == 0 and y == 0
    gosub main
  delay 200
  moveTo x + 8, y + 8
  delay 200