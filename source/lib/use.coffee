#step
stepForGetSkill = (_name) ->
  $.find _name
  if x > 0
    $.move x + 5, y + 10
    delay 500
    leftClick 1
    delay 1000

#get skill
$.getSkill = ->
  stepForGetSkill '获得技能'
  stepForGetSkill '获得技能Get'
  stepForGetSkill '确认才能'

#update skill
$.updateSkill = ->
  stepForGetSkill '升级'
  stepForGetSkill '升级Advance'
  stepForGetSkill '确认技能'

#use
$.use = (_name, _key) ->
  $.act '取消技能', 'x'
  delay 200
  switch _name
    when '普通攻击'
      skillAttack _key
    when '忍耐之歌'
      skillSimpleCancelAfter _key, 1500
    when '丰收之歌'
      skillSimpleCancelAfter _key, 5000
    when '迷惑的演奏'
      skillSimpleUse _key, 5000
    when '脱离险境'
      skillSimpleCancelAfter _key, 2000
    when '樱时雨'
      skillCheeryBlossomWind _key
    when '螺旋斩'
      skillShurikenCharging _key
    when '影子束缚术'
      skillSimpleStandBy _key, 500, 2000
    when '烟幕术'
      skillSimpleStandBy _key, 500, 2000
    when '影子隐身术'
      skillShadowStealth _key
    when '手里剑爆破术'
      skillSimpleStandBy _key, 1000, 2000
    when '手里剑风暴'
      skillSimpleAttack _key, 2000

#直接使用的技能
skillSimpleUse = (key, time) ->
  keyPress key, 1
  delay time

#使用然后取消的技能
#忍耐之歌、影子隐身术
skillSimpleCancelAfter = (key, time) ->
  keyPress key, 1
  delay time
  $.act '取消技能', 'x'

#基础技能类型
#重击、手里剑风暴
skillSimpleAttack = (key, time) ->
  keyPress key, 1
  delay 200
  skillAttack time

#脚下释放的技能
#影子束缚术
skillSimpleStandBy = (key, before, after) ->
  keyPress key, 1
  delay before
  $.move 0.45, 0.5
  delay 500
  leftClick 1
  delay after
  $.move 0.5, 0.5

#普通攻击
skillAttack = (time) ->
  keyDown 'Ctrl', 1
  delay 200
  leftClick 1
  delay time
  keyUp 'Ctrl', 1

#樱时雨
skillCheeryBlossomWind = (key) ->
  keyDown key, 1
  delay 5000
  keyUp key, 1
  delay 2000

#螺旋斩
skillShurikenCharging = (key) ->
  keyDown key, 1
  delay 200
  keyDown 'Ctrl', 1
  delay 3500
  leftClick 1
  delay 200
  keyUp 'Ctrl', 1
  delay 200
  keyUp key, 1

#影子隐身术
skillShadowStealth = (key) ->
  keyPress key, 1
  delay 500
  keyPress key, 1