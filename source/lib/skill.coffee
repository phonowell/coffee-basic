#step
stepForGetSkill = (name) ->
  findImage name
  if x > 0 and y > 0
    moveTo x + 5, y + 10
    delay 500
    leftClick 1
    delay 1000

#get skill
getSkill = ->
  stepForGetSkill '获得技能'
  stepForGetSkill '获得技能Get'
  stepForGetSkill '确认才能'

#update skill
updateSkill = ->
  stepForGetSkill '升级'
  stepForGetSkill '升级Advance'
  stepForGetSkill '确认技能'

#cancelSkill
cancelSkill = ->
  keyPress 'BackSpace', 1

#useSkill
useSkill = (name, key) ->
  cancelSkill()
  switch name
    when '普通攻击'
      skillAttack key
    when '忍耐之歌'
      skillSimpleCancelAfter key, 1500
    when '樱时雨'
      skillCheeryBlossomWind key
    when '螺旋斩'
      skillShurikenCharging key
    when '影子束缚术'
      skillSimpleStandBy key, 500, 1000
    when '烟幕术'
      skillSimpleStandBy key, 500, 1000
    when '影子隐身术'
      skillSimpleCancelAfter key, 1000
    when '手里剑爆破术'
      skillSimpleStandBy key, 500, 2000
    when '手里剑风暴'
      skillSimpleAttack key, 1000

#使用然后取消的技能
#忍耐之歌、影子隐身术
skillSimpleCancelAfter = (key, time) ->
  keyPress key, 1
  delay time
  cancelSkill()

#基础技能类型
#重击、手里剑风暴
skillSimpleAttack = (key, time) ->
  keyPress key, 1
  delay 200
  skillAttack time

#脚下释放的技能
#影子束缚术、烟幕术
skillSimpleStandBy = (key, before, after) ->
  keyPress key, 1
  delay before
  moveTo screenWidth * 0.5, screenHeight * 0.5 + 30
  delay 500
  leftClick 1
  delay after

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