$skill.天之印 = ->

  unless $level >= 30
    return

  $.press 'alt + minus'
  return true