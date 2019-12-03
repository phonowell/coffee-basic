监听 = ->

  # hp = getHp()
  mp = getMp()

  black = getBlack()
  white = getWhite()

  监听回刺()
  监听短兵相接()
  监听交击斩()
  监听飞刺()
  监听连攻()
  监听促进()
  监听六分反击()
  监听鼓励()
  监听倍增()
  监听交剑()
  监听即刻咏唱()
  监听醒梦()
  监听赤神圣()

  report()

$.setTimeout 清空信息, 3e3

$.setInterval 监听, 200