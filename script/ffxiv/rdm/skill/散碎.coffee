$skill.散碎 = ->

  unless $level >= 15
    return

  $.press 'alt + 6'
  return true