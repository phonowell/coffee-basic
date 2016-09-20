#=include lib/moveToIcon.coffee
#=include lib/divideOne.coffee

#main sub
main = ->

  #move to center of screen
  moveTo 1920 * 0.5, 1080 * 0.5
  delay 500
  leftClick()

  #first step
  moveToIcon '水结晶'
  divideOne()
  moveToIcon '合成栏空位'
  leftClick()

  #second step
  moveToIcon '火结晶'
  divideOne()
  moveToIcon '合成栏空位'
  leftClick()

  #third step
  moveToIcon '风结晶'
  divideOne()
  moveToIcon '合成栏空位'
  leftClick()

  #fire
  moveToIcon '合成按钮'
  leftClick()

  #wait and loop
  delay 8000
  main()