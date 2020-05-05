$skill.索敌 = ->

  if $isTargeting
    return true

  $.press 'f11'
  return true