中断咏唱 = ->
  unless isChanting()
    return
  $.press 'space'