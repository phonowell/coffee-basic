#=include lib/init.coffee
#=include lib/image.coffee
#=include lib/get.coffee

posX = 0
posY = 0

#step by
stepBy = (first, second, third) ->

  if posX == 0
    getImagePosition '合成栏空位'
    posX = x
    posY = y

  getItemByImage first, 1
  moveTo posX + 20, posY + 20
  delay 200
  leftClick 1

  getItemByImage second, 1
  moveTo posX + 80, posY + 20
  delay 200
  leftClick 1

  getItemByImage third, 1
  moveTo posX + 140, posY + 20
  delay 200
  leftClick 1

#main
main = ->

  moveTo screenWidth * 0.5, screenHeight * 0.5
  delay 200
  leftClick 1

  stepBy '生命药草', '基础药草', '生命药水50点'

  delay 500
  isie = isImageExist '合成按钮'
  if isie == true
    leftClick 1

  delay 6500
  main()

main()