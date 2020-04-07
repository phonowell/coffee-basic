$skill.索敌 = ->

  checkTargeting()
  if $isTargeting
    return true

  $.press 'f11'

  checkTargeting()
  return $isTargeting