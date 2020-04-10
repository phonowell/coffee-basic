$skill.直线射击 = ->

  unless hasStatus '直线射击预备'
    return

  $.press 'alt + 2'
  return true