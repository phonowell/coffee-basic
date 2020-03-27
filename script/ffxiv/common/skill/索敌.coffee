$skill.索敌 = ->

  hasTarget = isTargeting()
  if hasTarget
    return true

  $.press 'f11'

  hasTarget = isTargeting()
  return hasTarget