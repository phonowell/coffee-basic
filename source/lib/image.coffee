#is image exist
isImageExist = (name) =>
  findPic 0, 0, screenWidth, screenHeight, "D:\按键精灵\image\#{name}.bmp", 0.9, x, y
  if x == 0 and y == 0
    return false
  else
    return true