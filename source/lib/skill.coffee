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